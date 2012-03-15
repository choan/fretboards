class FretboardCollection
  
  attr_reader :fbs
  
  def initialize(settings = {})
    @opts = {
      
    }.update(settings)
    @fbs = []
  end
  
  def add(dots, attrs = {})
    if dots.is_a? Fretboard
      fb = dots
      if attrs[:title]
        fb.title = attrs[:title]
      end
    else
      fb = Fretboard.new(@opts)
      if dots.is_a? String
        fb.terse(dots, attrs)
      else
        fb.semiterse(dots, attrs)
      end
      # pp fb
    end
    @fbs << fb
    fb
  end
  
  
  
  def render_to_files(renderer, output_dir = '.')
    # TODO stablish filenaming
    @fbs.each do |fb|
      File.open("#{output_dir}/#{fb.title.gsub(/[^A-z0-9]/, "_")}.svg", "w") { |f| f.puts(renderer.render(fb)) }
    end
  end
  
  
end
