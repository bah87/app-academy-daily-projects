require_relative '../model_base'

class User < ModelBase
    
  def self.all
    data = QuestionDBConnection.instance.execute("SELECT * FROM users")
    data.map {|datum| User.new(datum)}
  end
  
  def self.find_by_id(id)
    data = QuestionDBConnection.instance.execute("SELECT * FROM users WHERE users.id = '#{id}'")
    User.new(data.first)
  end
  
  def self.find_by_name(fname,lname)
    data = QuestionDBConnection.instance.execute("SELECT * FROM users WHERE users.fname = '#{fname}' AND users.lname = '#{lname}'")
    data.map {|datum| User.new(datum)}
  end
  
  attr_accessor :fname, :lname
  attr_reader :id
  
  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end
  
  def create
    raise "#{self} already exists in database" if @id
    QuestionDBConnection.instance.execute(<<-SQL, @fname, @lname)
      INSERT INTO
        users (fname, lname)
      VALUES
        (?, ?);
    SQL
    @id = QuestionDBConnection.instance.last_insert_row_id
  end
  
  def update
    raise "#{self} does not exist in database" unless @id
    QuestionDBConnection.instance.execute(<<-SQL, @fname, @lname, @id)
      UPDATE
        users
      SET
        fname = ?, lname = ?
      WHERE
        id = ?;
    SQL
  end
  
  def save
    @id ? update : create
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