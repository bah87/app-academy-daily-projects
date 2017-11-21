require_relative '../model_base'

class User < ModelBase
  TABLE = "users"
  
  def self.find_by_name(fname,lname)
    data = QuestionDBConnection.instance.execute("SELECT * FROM users WHERE users.fname = '#{fname}' AND users.lname = '#{lname}'")
    data.map {|datum| User.new(datum)}
  end
  
  attr_accessor :fname, :lname
  
  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end
  
  def authored_questions
    Question.find_by_author_id(self.id)
  end
  
  def authored_replies
    Reply.find_by_user_id(self.id)
  end
  
  def followed_questions
    QuestionFollow.followed_questions_for_user_id(self.id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(self.id)
  end
  
  def average_karma
    data = QuestionDBConnection.instance.execute(<<-SQL, @id)
      SELECT 
        CASE COUNT(DISTINCT(questions.id))
        WHEN 0 THEN 0
        ELSE CAST(COUNT(questions.id) AS FLOAT) / COUNT(DISTINCT(questions.id))
        END AS karma
      FROM 
        users 
      LEFT OUTER JOIN 
        questions ON questions.user_id = users.id  
      LEFT OUTER JOIN 
        question_likes ON question_likes.question_id = questions.id
      WHERE 
        users.id = ?
      GROUP BY 
        users.id;
    SQL
    
    data.first.values.first
  end
  
end