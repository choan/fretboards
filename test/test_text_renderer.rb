require 'test/unit'
require 'fretboards'
require 'fretboards/renderer/text'

include Fretboards

class TextRendererTest < Test::Unit::TestCase
  def test_string_count
    fb = Fretboard.new
    renderer = Fretboards::Renderer::Text.new
    output = renderer.render(fb)
    assert_equal(4, output.split(' ').size)
  end

  def test_one_mark_each_string
    fb = Fretboard.new
    fb.terse(%w{ 0 0 0 3 })
    renderer = Fretboards::Renderer::Text.new
    output = renderer.render(fb)
    assert_equal("0 0 0 3", output)
  end
  
  def test_some_strings_unfretted
    fb = Fretboard.new
    fb.terse(%w{ 3/1 })
    renderer = Fretboards::Renderer::Text.new
    output = renderer.render(fb)
    assert_equal("x x x 3", output)
  end
  
  def test_obliviate_phantom_notes
    fb = Fretboard.new
    renderer = Fretboards::Renderer::Text.new
    fb.terse(%w{ 3/4 4/3 3/2 3/1? 5/1})
    output = renderer.render(fb)
    assert_equal("3 4 3 5", output)    

    fb.terse(%w{ 3/4 4/3 3/2 3/1!? 5/1})
    puts fb.marks.inspect
    output = renderer.render(fb)
    assert_equal("3 4 3 5", output)    
  end

end
