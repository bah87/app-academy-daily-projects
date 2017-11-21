require 'sqlite3'
require 'singleton'

class QuestionDBConnection < SQLite3::Database
  include Singleton
  
  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

require_relative 'ORMs/user'
require_relative 'ORMs/question'
require_relative 'ORMs/question_follow'
require_relative 'ORMs/reply'
require_relative 'ORMs/question_like'

# class Question
# 
#   def self.all
#     data = QuestionDBConnection.instance.execute("SELECT * FROM questions")
#     data.map {|datum| Question.new(datum)}
#   end
# 
#   def self.find_by_id(id)
#     data = QuestionDBConnection.instance.execute("SELECT * FROM questions WHERE questions.id = '#{id}'")
#     Question.new(data.first)
#   end
# 
#   def self.find_by_author_id(id)
#     data = QuestionDBConnection.instance.execute("SELECT * FROM questions WHERE questions.user_id = '#{id}'")
#     data.map {|datum| Question.new(datum)}
#   end
# 
#   attr_accessor :title, :body, :user_id
#   attr_reader :id
# 
#   def initialize(options)
#     @id = options['id']
#     @title = options['title']
#     @body = options['body']
#     @user_id = options['user_id']
#   end
# 
#   def create
#     raise "#{self} already exists in database" if @id
#     QuestionDBConnection.instance.execute(<<-SQL, @title, @body, @user_id)
#       INSERT INTO
#         questions (title, body, user_id)
#       VALUES
#         (?, ?, ?);
#     SQL
#     @id = QuestionDBConnection.instance.last_insert_row_id
#   end
# 
#   def update
#     raise "#{self} does not exist in database" unless @id
#     QuestionDBConnection.instance.execute(<<-SQL, @title, @body, @user_id, @id)
#       UPDATE
#         questions
#       SET
#         title = ?, body = ?, user_id = ?
#       WHERE
#         id = ?;
#     SQL
#   end
# 
#   def author 
#     User.find_by_id(self.user_id)
#   end
# 
#   def replies
#     Reply.find_by_question_id(self.id)
#   end
# end

# class User 
# 
#   def self.all
#     data = QuestionDBConnection.instance.execute("SELECT * FROM users")
#     data.map {|datum| User.new(datum)}
#   end
# 
#   def self.find_by_id(id)
#     data = QuestionDBConnection.instance.execute("SELECT * FROM users WHERE users.id = '#{id}'")
#     User.new(data.first)
#   end
# 
#   def self.find_by_name(fname,lname)
#     data = QuestionDBConnection.instance.execute("SELECT * FROM users WHERE users.fname = '#{fname}' AND users.lname = '#{lname}'")
#     data.map {|datum| User.new(datum)}
#   end
# 
#   attr_accessor :fname, :lname
#   attr_reader :id
# 
#   def initialize(options)
#     @id = options['id']
#     @fname = options['fname']
#     @lname = options['lname']
#   end
# 
#   def create
#     raise "#{self} already exists in database" if @id
#     QuestionDBConnection.instance.execute(<<-SQL, @fname, @lname)
#       INSERT INTO
#         users (fname, lname)
#       VALUES
#         (?, ?);
#     SQL
#     @id = QuestionDBConnection.instance.last_insert_row_id
#   end
# 
#   def update
#     raise "#{self} does not exist in database" unless @id
#     QuestionDBConnection.instance.execute(<<-SQL, @fname, @lname, @id)
#       UPDATE
#         users
#       SET
#         fname = ?, lname = ?
#       WHERE
#         id = ?;
#     SQL
#   end
# 
#   def authored_questions
#     Question.find_by_author_id(self.id)
#   end
# 
#   def authored_replies
#     Reply.find_by_user_id(self.id)
#   end
# 
# end

# class QuestionFollow
# 
#   def self.all
#     data = QuestionDBConnection.instance.execute("SELECT * FROM question_follows")
#     data.map {|datum| QuestionFollow.new(datum)}
#   end
# 
#   def self.find_by_id(id)
#     data = QuestionDBConnection.instance.execute("SELECT * FROM question_follows WHERE question_follows.id = '#{id}'")
#     QuestionFollow.new(data.first)
#   end
# 
#   def self.followers_for_question_id(id)
#     data = QuestionDBConnection.instance.execute(<<-SQL, id)
#       SELECT 
#         users.id, users.fname, users.lname
#       FROM
#         users
#       JOIN
#         question_follows ON users.id = question_follows.user_id
#       WHERE
#         question_follows.question_id = ?;
#     SQL
#     data.map { |datum| User.new(datum) }
#   end
# 
#   attr_accessor :user_id, :question_id
#   attr_reader :id
# 
#   def initialize(options)
#     @id = options['id']
#     @user_id = options['user_id']
#     @question_id = options['question_id']
#   end
# 
#   def create
#     raise "#{self} already exists in database" if @id
#     QuestionDBConnection.instance.execute(<<-SQL, @user_id, @question_id)
#       INSERT INTO
#         question_follows (user_id, question_id)
#       VALUES
#         (?, ?);
#     SQL
#     @id = QuestionDBConnection.instance.last_insert_row_id
#   end
# 
#   def update
#     raise "#{self} does not exist in database" unless @id
#     QuestionDBConnection.instance.execute(<<-SQL, @user_id, @question_id, @id)
#       UPDATE
#         question_follows
#       SET
#         user_id = ?, question_id = ?
#       WHERE
#         id = ?;
#     SQL
#   end
# end

# class Reply
# 
#   def self.all
#     data = QuestionDBConnection.instance.execute("SELECT * FROM replies")
#     data.map {|datum| Reply.new(datum)}
#   end
# 
#   def self.find_by_id(id)
#     data = QuestionDBConnection.instance.execute("SELECT * FROM replies WHERE replies.id = '#{id}'")
#     Reply.new(data.first)
#   end
# 
#   def self.find_by_user_id(id)
#     data = QuestionDBConnection.instance.execute("SELECT * FROM replies WHERE replies.user_id = '#{id}'")
#     data.map {|datum| Reply.new(datum)}
#   end
# 
#   def self.find_by_question_id(id)
#     data = QuestionDBConnection.instance.execute("SELECT * FROM replies WHERE replies.question_id = '#{id}'")
#     data.map {|datum| Reply.new(datum)}
#   end
# 
# 
#   attr_accessor :body, :user_id, :question_id, :parent_id
#   attr_reader :id
# 
#   def initialize(options)
#     @id = options['id']
#     @body = options['body']
#     @user_id = options['user_id']
#     @question_id = options['question_id']
#     @parent_id = options['parent_id']
#   end
# 
#   def create
#     raise "#{self} already exists in database" if @id
#     QuestionDBConnection.instance.execute(<<-SQL, @body, @user_id, @question_id, @parent_id)
#       INSERT INTO
#         replies (body, user_id, question_id, parent_id)
#       VALUES
#         (?, ?, ?, ?);
#     SQL
#     @id = QuestionDBConnection.instance.last_insert_row_id
#   end
# 
#   def update
#     raise "#{self} does not exist in database" unless @id
#     QuestionDBConnection.instance.execute(<<-SQL, @body, @user_id, @question_id, @parent_id, @id)
#       UPDATE
#         replies
#       SET
#         body = ?, user_id = ?, question_id = ?, parent_id = ?
#       WHERE
#         id = ?;
#     SQL
#   end
# 
#   def author 
#     User.find_by_id(self.user_id)
#   end
# 
#   def question 
#     Question.find_by_id(self.question_id)
#   end
# 
#   def parent_reply
#     Reply.find_by_id(self.parent_id)
#   end
# 
#   def child_replies
#     QuestionDBConnection.instance.execute("SELECT * FROM replies WHERE replies.parent_id = '#{self.id}'")
#   end
# end

# class QuestionLike
# 
#   def self.all
#     data = QuestionDBConnection.instance.execute("SELECT * FROM question_likes")
#     data.map {|datum| QuestionLike.new(datum)}
#   end
# 
#   def self.find_by_id(id)
#     data = QuestionDBConnection.instance.execute("SELECT * FROM question_likes WHERE question_likes.id = '#{id}'")
#     QuestionLike.new(data.first)
#   end
# 
#   attr_accessor :user_id, :question_id
#   attr_reader :id
# 
#   def initialize(options)
#     @id = options['id']
#     @user_id = options['user_id']
#     @question_id = options['question_id']
#   end
# 
#   def create
#     raise "#{self} already exists in database" if @id
#     QuestionDBConnection.instance.execute(<<-SQL, @user_id, @question_id)
#       INSERT INTO
#         question_likes (user_id, question_id)
#       VALUES
#         (?, ?);
#     SQL
#     @id = QuestionDBConnection.instance.last_insert_row_id
#   end
# 
#   def update
#     raise "#{self} does not exist in database" unless @id
#     QuestionDBConnection.instance.execute(<<-SQL, @user_id, @question_id, @id)
#       UPDATE
#         question_likes
#       SET
#         user_id = ?, question_id = ?
#       WHERE
#         id = ?;
#     SQL
#   end
# end