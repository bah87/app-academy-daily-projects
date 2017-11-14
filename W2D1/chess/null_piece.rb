require 'singleton'

class NullPiece
  include Singleton
  
  def color 
    :light_yellow
  end
  
  def symbol
    " "
  end
  
  def to_str
    symbol.to_s
  end
end