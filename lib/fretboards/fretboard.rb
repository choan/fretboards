module Fretboards
  class Fretboard
  
    SYMBOLS = {
      :root => "R",
      :bluenote => "x"
    }
  
    DEFAULT_SYMBOL = "*"
  
    attr_reader :marks
  
    def initialize(conf, &block)
      # puts "corriendo el fretborad"
      @marks = []
      @conf = conf
      self.instance_eval &block if block_given?
    end
  

    def mark(opts, &block)
      if block_given?
        with_string(opts[:string], &block)
      else
        @marks << opts
      end
    end
  
    def with_string(string_number, &block)
      s = FretboardString.new
      s.instance_eval &block
      s.marks.each do |m|
        mark({ :string => string_number }.update(m) )
      end
      self
    end
  
    def to_s
      render_ascii
    end
  
    def render_ascii
      lines = []
      if fret_start == 0
        syms = []
        (1..strings).each do |string_number|
          if @marks.find { |m| m[:fret] == 0 && m[:string] == string_number }
            syms << "o"
          else
            syms << " "
          end
        end
        lines << syms.reverse.join("  ")
      else
        lines << ""
      end
      start = fret_start == 0 ? 1 : fret_start
      (start..fret_end).each do |fret_number|
        syms = []
        (1..strings).each do |string_number|
          if m = @marks.find { |m| m[:fret] == fret_number && m[:string] == string_number }
            syms << (m[:symbol] && SYMBOLS[m[:symbol]] || DEFAULT_SYMBOL)
          else
            syms << "│"
          end
        
        end
        lines << syms.reverse.join("  ")
      end      
      lines << ""
      pic = lines.join("\n#{fret_division}\n")
      pic
    end
  
    # private
    def fret_start
      @conf[:fret_start] || 0
    end
  
    def fret_end
      @conf[:fret_end] || 4
    end
  
    def strings
      @conf[:strings] || 4
    end
  
    def fret_division
      "├──" + "┼──" * (strings - 2) + "┤"
    end
  
  end
end