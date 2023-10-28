require 'test/unit'
$:<< File.dirname(__FILE__) + '/../lib'
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

  def test_terse_full
    fb = Fretboard.new
    fb.terse %w{ 1/4-3(5) }
    assert_equal([{:string => 4, :finger => 3, :function => "5", :fret => 1}], fb.marks)
  end

  def test_terse_minimal
    fb = Fretboard.new
    fb.terse %w{ 1 }
    assert_equal([{ :string => 4, :fret => 1 } ], fb.marks)
  end

  def test_terse_barre
    fb = Fretboard.new
    fb.terse %w{ 3 1[ 1] 0 }
    assert_equal([{:fret => 1, :from => 3, :to => 2 }], fb.barres)
  end

  def test_terse_unfinished_barre
    fb = Fretboard.new
    fb.terse %w{ 3 1[ 1 1 }
    assert_equal([{:fret => 1, :from => 3, :to => 1 }], fb.barres)
  end

  def test_terse_symbols
    # puts "symbols"
    fb = Fretboard.new
    fb.terse %w{ 3! }
    assert_equal(:root, fb.marks.first[:symbol])

    fb = Fretboard.new
    fb.terse %w{ 3? }
    assert_equal(:phantom, fb.marks.first[:symbol])

    fb = Fretboard.new
    fb.terse %w{ 3!? }
    assert_equal(:phantom_root, fb.marks.first[:symbol])

  end

  def test_fret_range
    fb = Fretboard.new
    fb.terse %w{ 0 0 0 3 }
    assert_equal([1, 4], fb.fret_range)
    fb = Fretboard.new
    fb.terse %w{ 0 0 0 5 }
    assert_equal([1, 5], fb.fret_range)
    fb = Fretboard.new
    fb.terse %w{ 7 6 5 9 }
    assert_equal([5, 9], fb.fret_range)
  end

  def test_fret_range_with_offset
    fb = Fretboard.new
    fb.terse %w{ 0 5 7 7 }
    fb.set_offset 5
    assert_equal([5, 8], fb.fret_range)
  end

end
