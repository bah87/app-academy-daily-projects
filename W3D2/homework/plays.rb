require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton 
  
  def initialize
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Play
  attr_accessor :title, :year, :playwright_id
  
  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM plays")
    data.map { |datum| Play.new(datum) }
  end
  
  def initialize(options)
    @id = options['id'] # when user wants to create new instance w/o id
    # since it's auto-incremented, this will just return nil which is ok
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end
  
  def create
    raise "#{self} already in database" if @id #this play instance already exists
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
      SQL
    @id = PlayDBConnection.instance.last_insert_row_id
  end
  
  def update
    raise "#{self} not yet in database" unless @id
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id, @id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end
end