require_relative '../model_base'

class Question < ModelBase
  TABLE = "questions"
  
  def self.find_by_author_id(id)
    data = QuestionDBConnection.instance.execute("SELECT * FROM questions WHERE questions.user_id = '#{id}'")
    data.map {|datum| Question.new(datum)}
  end
  
  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end
  
  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end
  
  attr_accessor :title, :body, :user_id
  
  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end
  
  def author 
    User.find_by_id(self.user_id)
  end
  
  def replies
    Reply.find_by_question_id(self.id)
  end
  
  def followers 
    QuestionFollow.followers_for_question_id(self.id)
  end
  
  def likers
    QuestionLike.likers_for_question_id(self.id)
  end
  
  def num_likers
    QuestionLike.num_likes_for_question_id(self.id)
  end
end