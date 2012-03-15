module Fretboards
  module Pitch
    
    TABLE = {
      "c" => 0,
      "cis" => 1,
      "des" => 1,
      "d" => 2,
      "dis" => 3,
      "ees" => 3,
      "e" => 4,
      "f" => 5,
      "fis" => 6,
      "ges" => 6,
      "g" => 7,
      "gis" => 8,
      "aes" => 8,
      "a" => 9,
      "ais" => 10,
      "bes" => 10,
      "b" => 11
    }
    
    def self.to_diff(name)
      pitch, alt, octave = name.scan(/([a-g](es|is)?)([',]*)/)[0]
      base = TABLE[pitch]
      octave_shift = if octave.nil?
        -12
      elsif octave.start_with?(",")
        -12 * (octave.length + 1)
      else
        12 * (octave.length - 1)
      end
      # pp octave_shift
      diff = base + octave_shift
      diff
    end
    
  end
end