require_relative '../model_base'

class QuestionLike < ModelBase
  TABLE = "question_likes"
  
  def self.likers_for_question_id(id)
    data = QuestionDBConnection.instance.execute(<<-SQL, id)
      SELECT
        users.id, users.fname, users.lname
      FROM
        users
      JOIN
        question_likes ON users.id = question_likes.user_id
      WHERE
        question_likes.question_id = ?;
    SQL
    data.map { |datum| User.new(datum) }
  end
  
  def self.num_likes_for_question_id(id)
    data = QuestionDBConnection.instance.execute(<<-SQL, id)
      SELECT
        COUNT(users.id) AS num_likes
      FROM
        users
      JOIN
        question_likes ON users.id = question_likes.user_id
      WHERE
        question_likes.question_id = ?;
    SQL
    
    data.first['num_likes']
  end
  
  def self.liked_questions_for_user_id(id)
    data = QuestionDBConnection.instance.execute(<<-SQL, id)
      SELECT
        questions.id, questions.title, questions.body, questions.user_id
      FROM
        questions
      JOIN
        question_likes ON questions.id = question_likes.question_id
      WHERE 
        question_likes.user_id = ?;
    SQL
    data.map { |datum| Question.new(datum) }
  end
  
  def self.most_liked_questions(n)
    data = QuestionDBConnection.instance.execute(<<-SQL, n)
      SELECT 
        questions.id, questions.title, questions.body, questions.user_id
      FROM
        questions
      JOIN
        question_likes ON questions.id = question_likes.question_id
      GROUP BY
        questions.id
      ORDER BY 
        COUNT(question_likes.user_id) DESC
      LIMIT ?;
    SQL
    data.map {|datum| Question.new(datum)}
  end
  
  attr_accessor :user_id, :question_id

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end
end