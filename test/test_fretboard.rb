require 'test/unit'
require 'fretboards'

include Fretboards

# TODO write useful tests
class FretboardTest < Test::Unit::TestCase
  
  def test_string_count
    uke = Fretboard.new()
    assert_equal(4, uke.string_count)

    guit = Fretboard.new(:tuning => Fretboards::Tuning::GUITAR)
    assert_equal(6, guit.string_count)
  end
  
  def test_mark
    fb = Fretboard.new
    fb.mark :string => 1, :fret => 5
    assert_equal([{:string => 1, :fret => 5}], fb.marks)
  end
  
  def test_barre
    fb = Fretboard.new(:tuning => %w{ g' c' e' a' })
    fb.barre 1
    assert_equal([{:fret => 1, :from => 4, :to => 1 }], fb.barres)
  end
  
  def test_mute
    fb = Fretboard.new
    fb.mute(1)
    assert_equal([1], fb.mutes)
  end
  
  def test_open
    fb = Fretboard.new
    fb.open(1)
    assert_equal([{:string => 1, :fret => 0}], fb.marks)
  end
  
end