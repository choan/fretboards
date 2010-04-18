class FretboardString
  
  attr_reader :marks
  
  def initialize
    @marks = []
  end
  
  def mark(opts)
    @marks << opts
  end
  
end
