# require_relative '../questions_database'

class Question
  
  def self.all
    data = QuestionDBConnection.instance.execute("SELECT * FROM questions")
    data.map {|datum| Question.new(datum)}
  end
  
  def self.find_by_id(id)
    data = QuestionDBConnection.instance.execute("SELECT * FROM questions WHERE questions.id = '#{id}'")
    Question.new(data.first)
  end
  
  def self.find_by_author_id(id)
    data = QuestionDBConnection.instance.execute("SELECT * FROM questions WHERE questions.user_id = '#{id}'")
    data.map {|datum| Question.new(datum)}
  end
  
  attr_accessor :title, :body, :user_id
  attr_reader :id
  
  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end
  
  def create
    raise "#{self} already exists in database" if @id
    QuestionDBConnection.instance.execute(<<-SQL, @title, @body, @user_id)
      INSERT INTO
        questions (title, body, user_id)
      VALUES
        (?, ?, ?);
    SQL
    @id = QuestionDBConnection.instance.last_insert_row_id
  end
  
  def update
    raise "#{self} does not exist in database" unless @id
    QuestionDBConnection.instance.execute(<<-SQL, @title, @body, @user_id, @id)
      UPDATE
        questions
      SET
        title = ?, body = ?, user_id = ?
      WHERE
        id = ?;
    SQL
  end
  
  def author 
    User.find_by_id(self.user_id)
  end
  
  def replies
    Reply.find_by_question_id(self.id)
  end
end