class ModelBase
  attr_reader :id
  
  def self.all
    data = QuestionDBConnection.instance.execute("SELECT * FROM #{self::TABLE}")
    data.map {|datum| self.new(datum)}
  end

  def self.find_by_id(id)
    data = QuestionDBConnection.instance.execute("SELECT * FROM #{self::TABLE} WHERE #{self::TABLE}.id = '#{id}'")
    self.new(data.first)
  end
  
  def self.where(options)
    constraint = options.to_a.map { |field| "#{self::TABLE}.#{field.first} = '#{field.last}'" }.join(" AND ")
    data = QuestionDBConnection.instance.execute("SELECT * FROM #{self::TABLE} WHERE #{constraint}")
  end
  
  def self.method_missing(m, *args)
    m = m.to_s.sub(/find_by_/, "").split("_and_")
  end
  
  def create
    raise "#{self} already exists in database" if @id
    values = self.instance_variables.drop(1).map(&:to_s).map { |str| str[1..-1] }.map(&:to_sym).map { |sym| self.send(sym) }
    QuestionDBConnection.instance.execute(<<-SQL, *values)
      INSERT INTO
        #{self.class::TABLE} (#{self.instance_variables.drop(1).map(&:to_s).map { |str| str[1..-1] }.join(", ")})
      VALUES
        (#{self.instance_variables.drop(1).map { |sym| "?" }.join(", ")});
    SQL
    @id = QuestionDBConnection.instance.last_insert_row_id
  end
  
  def update
    raise "#{self} does not exist in database" unless @id
    values = self.instance_variables.rotate.map(&:to_s).map { |str| str[1..-1] }.map(&:to_sym).map { |sym| self.send(sym) }
    QuestionDBConnection.instance.execute(<<-SQL, *values)
      UPDATE
        #{self.class::TABLE}
      SET
        #{self.instance_variables.drop(1).map(&:to_s).map { |str| str[1..-1] + " = ?"}.join(", ")}
      WHERE
        #{self.instance_variables[0].to_s[1..-1] + " = ?" };
    SQL
  end
  
  def save
    @id ? update : create
  end
  
end
