require_relative '../model_base'

class Reply < ModelBase
  TABLE = "replies"
  
  def self.find_by_user_id(id)
    data = QuestionDBConnection.instance.execute("SELECT * FROM replies WHERE replies.user_id = '#{id}'")
    data.map {|datum| Reply.new(datum)}
  end
  
  def self.find_by_question_id(id)
    data = QuestionDBConnection.instance.execute("SELECT * FROM replies WHERE replies.question_id = '#{id}'")
    data.map {|datum| Reply.new(datum)}
  end
  
  
  attr_accessor :body, :user_id, :question_id, :parent_id
  
  def initialize(options)
    @id = options['id']
    @body = options['body']
    @user_id = options['user_id']
    @question_id = options['question_id']
    @parent_id = options['parent_id']
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