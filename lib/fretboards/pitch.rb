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
      "beses" => 9,
      "ais" => 10,
      "bes" => 10,
      "b" => 11
    }
    
    def self.to_diff(name)
      pitch, alt, octave = name.scan(/([a-g](es|is){0,2})([',]*)/)[0]
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

    def self.from_diff(diff)
      diff += 12
      octave_direction = diff > 0 ? 1 : -1
      abs_diff = diff.abs
      octave_shift = diff / 12
      shift = diff % 12
      s_pitch = TABLE.find { |k, v| v == shift }.first
      suffix = (octave_direction > 0 ? "'" : ',') * octave_shift
      s_pitch + suffix
    end
        
  end
end