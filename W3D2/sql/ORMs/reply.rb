# require_relative '../questions_database'

class Reply
  
  def self.all
    data = QuestionDBConnection.instance.execute("SELECT * FROM replies")
    data.map {|datum| Reply.new(datum)}
  end
  
  def self.find_by_id(id)
    data = QuestionDBConnection.instance.execute("SELECT * FROM replies WHERE replies.id = '#{id}'")
    Reply.new(data.first)
  end
  
  def self.find_by_user_id(id)
    data = QuestionDBConnection.instance.execute("SELECT * FROM replies WHERE replies.user_id = '#{id}'")
    data.map {|datum| Reply.new(datum)}
  end
  
  def self.find_by_question_id(id)
    data = QuestionDBConnection.instance.execute("SELECT * FROM replies WHERE replies.question_id = '#{id}'")
    data.map {|datum| Reply.new(datum)}
  end
  
  
  attr_accessor :body, :user_id, :question_id, :parent_id
  attr_reader :id
  
  def initialize(options)
    @id = options['id']
    @body = options['body']
    @user_id = options['user_id']
    @question_id = options['question_id']
    @parent_id = options['parent_id']
  end
  
  def create
    raise "#{self} already exists in database" if @id
    QuestionDBConnection.instance.execute(<<-SQL, @body, @user_id, @question_id, @parent_id)
      INSERT INTO
        replies (body, user_id, question_id, parent_id)
      VALUES
        (?, ?, ?, ?);
    SQL
    @id = QuestionDBConnection.instance.last_insert_row_id
  end
  
  def update
    raise "#{self} does not exist in database" unless @id
    QuestionDBConnection.instance.execute(<<-SQL, @body, @user_id, @question_id, @parent_id, @id)
      UPDATE
        replies
      SET
        body = ?, user_id = ?, question_id = ?, parent_id = ?
      WHERE
        id = ?;
    SQL
  end
  
  def author 
    User.find_by_id(self.user_id)
  end
  
  def question 
    Question.find_by_id(self.question_id)
  end
  
  def parent_reply
    Reply.find_by_id(self.parent_id)
  end
  
  def child_replies
    QuestionDBConnection.instance.execute("SELECT * FROM replies WHERE replies.parent_id = '#{self.id}'")
  end
end