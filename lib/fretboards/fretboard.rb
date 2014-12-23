require "fretboards/pitch"

module Fretboards
  class Fretboard

    attr_reader :marks, :labels, :barres, :conf, :opens, :mutes, :label_offset, :offset

    attr_accessor :title

    def initialize(conf = {}, &block)
      @labels = []
      @marks = []
      @barres = []
      @conf = {
        # default tuning is ukulele tuning
        :tuning => Fretboards::Tuning::UKULELE
      }
      @mutes = []
      @opens = []
      @offset = 0
      @label_offset = 0
      configure(conf)
      self.instance_eval block if block_given?
    end


    def configure(conf)
      @conf.update(conf)
    end

    def terse(a, opts = {})
      a = a.split(/\s+/) if a.is_a?(String)
      self.title = opts[:title] if opts[:title]
      barres = {}
      a.each_with_index do |m, i|
        attrs = {}
        attrs[:string] = m.match(%r{/(\d+)})[1].to_i rescue index_to_string_number(i)
        attrs[:fret] = m.match(%r{^(\d+)})[1].to_i rescue nil
        has_mute = m.start_with?('x')
        if !attrs[:fret] && !has_mute
          if pitch = m.match(/^([a-g](es|is){0,2}[',]*)/)[1]
            attrs[:fret] = pitch_to_fret(pitch, attrs[:string])
            attrs[:pitch] = pitch
          end
        end
        attrs[:finger] = m.match(%r{-(\d+)})[1].to_i rescue nil
        attrs[:function] = m.match(%r{\(([^\)]*)\)})[1] rescue nil

        if m.include?("!") && m.include?("?")
          attrs[:symbol] = :phantom_root
        else
          attrs[:symbol] = :root if m.include?("!")
          attrs[:symbol] = :phantom if m.include?("?")
        end

        attrs.reject! { |k, v| v.nil? }
        mark(attrs) if attrs[:fret]

        mute(attrs[:string]) if has_mute

        bs = m[-1..-1] == "["
        barres[attrs[:fret]] = [attrs[:fret], attrs[:string]] if bs
        be = m[-1..-1] == "]"
        barres[attrs[:fret]] << attrs[:string] if be
      end

      barres.each do |k, b|
        fret, f, t = *b
        barre(fret, f, t || 1)
      end
      self
    end

    def set_offset(n)
      @offset = n
      self
    end
    
    def set_label_offset(n)
      @label_offset = n
      self
    end
    

    def mark(s, f = nil, settings = {})
      if !s.is_a? Hash
        s = { :string => s, :fret => f }.update(settings)
      else
        s = {}.merge(s)
      end
      @marks.push(s)
    end

    def label(number, offset = 0)
      # TODO we're still not painting this
      @labels[offset] = number
    end

    def mute(s)
      @mutes << s
    end

    def open(s)
      mark({:fret => 0, :string => s})
    end

    def barre(fret, from = :max, to = 1)
      if fret.is_a? Hash
        b = {}.update(fret)
      else
        from = index_to_string_number(0) if from == :max
        b = {:fret => fret, :from => from, :to => to}
      end
      @barres.push(b)
    end

    def string_count
      # @conf[:string_count] ||
      @conf[:tuning].length
    end

    def pitch_to_fret(pitch, string)
      diff = Pitch.to_diff(pitch)
      tunings = tuning_to_diffs
      t = tunings[string_number_to_index(string)]
      # TODO warn if < 0
      diff - t
    end

    def mark_pitch(pitch, opts = { })
      diff = Pitch.to_diff(pitch)
      tunings = tuning_to_diffs
      if !opts[:string]
        tunings.each_with_index do |t, i|
          # puts diff - t
          if t <= diff && (!opts[:range] || opts[:range].include?(diff - t))
            # puts pitch, diff-t, opts[:range]
            mark(index_to_string_number(i), diff - t, :symbol => opts[:symbol], :finger => opts[:finger])
          end
        end
      else
        # TODO Warning if the fret number is negative
        mark(opts[:string], diff - tunings[string_number_to_index(string)])
      end
    end

    def index_to_string_number(i)
      string_count - i
    end

    def string_number_to_index(i)
      # 4 -> 0
      # 1 -> 3
      -(i - string_count)
    end

    def tuning_to_diffs
      @tuning_diffs ||= @conf[:tuning].map { |p| Pitch.to_diff(p) }
    end

    def clone
      copy = Fretboard.new
      copy.configure(@conf)
      @marks.each { |m| copy.mark(m) }
      @barres.each { |m| copy.barre(m) }
      @mutes.each { |m| copy.mute(m) }
      copy
    end

    def transpose(steps)
      copy = self.clone
      copy.transpose_marks(steps)
      copy.transpose_barres(steps)
      copy
    end

    alias :+ transpose

    def -(delta)
      transpose(-delta)
    end

    def transpose_marks(steps)
      @marks.each do |m|
        m[:fret] += steps
      end
    end

    def transpose_barres(steps)
      @barres.each do |b|
        b[:fret] += steps
      end
    end

    def fret_range(size = 4)
      if marks.empty?
        [1, size]
      else
        min = marks.inject { |sum, i| i[:fret] < sum[:fret] ? i : sum }[:fret]
        max = marks.inject { |sum, i| i[:fret] > sum[:fret] ? i : sum }[:fret]
        if size >= max
          [1, size]
        else
          # puts "#{self.title} pasa por el segundo hilo"
          min = 1 if min == 0
          max = (min + size) if (size > (max - min) )
          [min + offset, max + offset]
        end
      end
    end




  end
end