require_relative '../model_base'

class QuestionFollow < ModelBase
  TABLE = "question_follows"
  
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
  
  def self.followed_questions_for_user_id(id)
    data = QuestionDBConnection.instance.execute(<<-SQL, id)
      SELECT 
        questions.id, questions.title, questions.body, questions.user_id
      FROM 
        questions
      JOIN 
        question_follows ON question_follows.question_id = questions.id 
      WHERE 
        question_follows.user_id = ?;
    SQL
    data.map {|datum| Question.new(datum)}
  end
  
  def self.most_followed_questions(n)
    data = QuestionDBConnection.instance.execute(<<-SQL, n)
      SELECT 
        questions.id, questions.title, questions.body, questions.user_id
      FROM 
        questions
      JOIN 
        question_follows ON question_follows.question_id = questions.id
      GROUP BY 
        questions.id
      ORDER BY
        COUNT(question_follows.user_id) DESC
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