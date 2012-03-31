require 'fretboards/renderer/svg'

module Fretboards

  class FretboardCollection

    def initialize(settings = {})
      @col = []
      @forms = {}
      @tuning = %w{ g' c' e' a' }
      @table = "default"
    end
    
    def set_tuning(a)
      @tuning = a
    end

    def add(dots, attrs = {})
      fb = fretboard(dots, attrs)
      @col << fb
      fb
    end
    
    def define(title, a, attrs = {})
      form_add(title, a, { :title => title }.merge(attrs))
    end

    def use(title)
      raise "#{title} form not available" unless @forms[title]
      @forms[title] 
    end


    def fretboard(dots, opts = {})
      if opts.is_a? String
        attrs = {}
        attrs[:title] = opts
      else
        attrs = opts.dup
      end
      if dots.is_a? Fretboard
        fb = dots
        fb.title = attrs[:title] if attrs[:title]
      else
        fb = Fretboard.new(:tuning => @tuning)
        fb.terse(dots, attrs)
      end
      fb
    end

    def form_add(name, a, attrs = {})
      add(form_create(name, a, attrs))
    end

    def form_create(name, a, attrs = {})
      @forms[name] = fretboard(a, attrs)
    end


    def renderer
      Renderer::Svg.new
    end

    def render_to_files(output_dir = '.')
      # TODO may we use a filenaming lambda?
      @col.each do |fb|
        File.open("#{output_dir}/#{fb.title.gsub(/[^A-z0-9]/, "_")}.svg", "w") { |f| f.puts(renderer.render(fb)) }
      end
    end

  end

end