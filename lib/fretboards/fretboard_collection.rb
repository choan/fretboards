require 'fretboards/renderer/svg'

module Fretboards

  class FretboardCollection

    def initialize(settings = {})
      @opts = {

      }.update(settings)
      @col = []
      @forms = {}
    end

    def add(dots, attrs = {})
      fb = fretboard(dots, attrs)
      @col << fb
      fb
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
        fb = Fretboard.new(@opts)
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

    def form_use(name, delta = 0, attrs = {})
      raise "Form #{name} not found" if @forms[name].nil?
      add(@forms[name].transpose(delta), attrs)
    end

    def renderer
      Renderer::Svg.new
    end

    def render_to_files(output_dir = '.')
      # TODO stablish filenaming pattern
      # TODO raise if not available name
      @col.each do |fb|
        File.open("#{output_dir}/#{fb.title.gsub(/[^A-z0-9]/, "_")}.svg", "w") { |f| f.puts(renderer.render(fb)) }
      end
    end

  end

end