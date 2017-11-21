# require_relative '../questions_database'

class QuestionFollow
    
  def self.all
    data = QuestionDBConnection.instance.execute("SELECT * FROM question_follows")
    data.map {|datum| QuestionFollow.new(datum)}
  end
  
  def self.find_by_id(id)
    data = QuestionDBConnection.instance.execute("SELECT * FROM question_follows WHERE question_follows.id = '#{id}'")
    QuestionFollow.new(data.first)
  end
  
  def self.followers_for_question_id(id)
    data = QuestionDBConnection.instance.execute(<<-SQL, id)
      SELECT 
        users.id, users.fname, users.lname
      FROM
        users
      JOIN
        question_follows ON users.id = question_follows.user_id
      WHERE
        question_follows.question_id = ?;
    SQL
    data.map { |datum| User.new(datum) }
  end
  
  attr_accessor :user_id, :question_id
  attr_reader :id
  
  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end
  
  def create
    raise "#{self} already exists in database" if @id
    QuestionDBConnection.instance.execute(<<-SQL, @user_id, @question_id)
      INSERT INTO
        question_follows (user_id, question_id)
      VALUES
        (?, ?);
    SQL
    @id = QuestionDBConnection.instance.last_insert_row_id
  end
  
  def update
    raise "#{self} does not exist in database" unless @id
    QuestionDBConnection.instance.execute(<<-SQL, @user_id, @question_id, @id)
      UPDATE
        question_follows
      SET
        user_id = ?, question_id = ?
      WHERE
        id = ?;
    SQL
  end
end