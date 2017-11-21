# require_relative '../questions_database'

class QuestionLike
  
  def self.all
    data = QuestionDBConnection.instance.execute("SELECT * FROM question_likes")
    data.map {|datum| QuestionLike.new(datum)}
  end

  def self.find_by_id(id)
    data = QuestionDBConnection.instance.execute("SELECT * FROM question_likes WHERE question_likes.id = '#{id}'")
    QuestionLike.new(data.first)
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
        question_likes (user_id, question_id)
      VALUES
        (?, ?);
    SQL
    @id = QuestionDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} does not exist in database" unless @id
    QuestionDBConnection.instance.execute(<<-SQL, @user_id, @question_id, @id)
      UPDATE
        question_likes
      SET
        user_id = ?, question_id = ?
      WHERE
        id = ?;
    SQL
  end
end