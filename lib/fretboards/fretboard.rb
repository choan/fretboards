module Fretboards
  class Fretboard
  
    SYMBOLS = {
      :root => "R",
      :bluenote => "x"
    }
  
    DEFAULT_SYMBOL = "*"
  
    attr_reader :marks

    def self.from_s(s)
      if s.match(/^\d+$/)
        self.parse_simple(s)
      else
        self.parse_verbose(s)
        # raise "Unimplemented"
      end
    end
    
    def self.parse_simple(s)
      string_count = s.length
      f = self.new
      s.split("").each_with_index do |x, i|
        f.mark(:string => string_count - i, :fret => x.to_i)
      end
      f
    end
    
    def self.parse_verbose(s)
      fb = self.new
      if s.start_with? "("
        conf, s = *s.split(")")
        s.strip!
        conf = conf[1..-1]
        conf_fragments = conf.split(/\s*,\s*/)
        conf_fragments.each do |cf|
          if cf.start_with? "frets:"
            fst, fend = *cf.scan(/\d+/).map { |x| x.to_i }
            fb.configure(:fret_start => fst, :fret_end => fend)
          elsif cf.start_with? "label:"
            fst, fend = *cf.scan(/\d+/).map { |x| x && x.to_i }
            fb.label_fret(fst, fend || 0)
          elsif cf.start_with? "barre:"
            barre_fret, barre_start, barre_end = *cf.scan(/\d+/).map(&:to_i)
            fb.barre(:fret => barre_fret, :start => barre_start, :end => barre_end)
          else
            # unimplemented
          end
        end
        require "pp"
        pp conf_fragments
      end
      s = s.sub(/,\s?$/, "")
      marks = s.split(/\s*,\s*/)
      marks.each do |m|
        fragments = m.split(/\s+/)
        params = {}
        params[:fret], params[:string] = *fragments.shift.split("/").map { |x| x.to_i }
        fragments.each do |f|
          if f.start_with? "f"
            params[:finger] = f[1..-1]
          else
            params[:function] = f.to_sym
          end
        end
        fb.mark params
      end
      fb
    end
  
    def initialize(conf = {}, &block)
      # puts "corriendo el fretborad"
      @marks = []
      @fret_labels = []
      @barres = []
      @conf = {}
      configure(conf)
      self.instance_eval &block if block_given?
    end
  
    def configure(conf = {})
      @conf.update(conf)
    end



    def mark(opts, &block)
      if block_given?
        with_string(opts[:string], &block)
      else
        @marks << opts
      end
    end
    
    def label_fret(number, offset = 0)
      @fret_labels[offset] = number
    end
  
    def with_string(string_number, &block)
      s = FretboardString.new
      s.instance_eval &block
      s.marks.each do |m|
        mark({ :string => string_number }.update(m) )
      end
      self
    end
    
    def barre(opts)
      @barres << opts.clone
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
        syms << " "
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
        if !@fret_labels[fret_number].nil?
          syms << @fret_labels[fret_number]
        else
          syms << " "
        end
        lines << syms.reverse.join("  ")
      end      
      lines << ""
      pic = lines.join("\n#{fret_division}\n")
      pic
    end
    
    def transpose(delta, opts = {}, &block)
      dup = self.clone
      dup.configure(opts)
      dup.instance_eval &block if block_given?
      dup.marks.map! do |m|
        m[:fret] += delta
        m
      end
      dup
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
      "   ├──" + "┼──" * (strings - 2) + "┤"
    end
  
  end
end