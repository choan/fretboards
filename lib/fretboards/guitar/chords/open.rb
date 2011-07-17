module Fretboards::Guitar::Chords::Open
  
  Fretboards.add(self.name, "G") do
    ::Fretboards::Fretboard.new(:strings => 6, :fret_start => 0, :fret_end => 4, :position => :absolute) do
      mark :string => 6, :fret => 3, :finger => 2, :function => :root
      mark :string => 5, :fret => 2, :finger => 1, :function => :third
      mark :string => 4, :fret => 0, :function => :fifth
      mark :string => 3, :fret => 0, :function => :root
      mark :string => 2, :fret => 0, :function => :third
      mark :string => 1, :fret => 3, :finger => 3, :function => :root
    end    
  end
  
  Fretboards.add(self.name, "D") do
    ::Fretboards::Fretboard.new(:strings => 6, :fret_start => 0, :fret_end => 4, :position => :absolute) do
      mark :string => 6, :fret => :x
      mark :string => 5, :fret => :x
      mark :string => 4, :fret => 0, :function => :root
      mark :string => 3, :fret => 2, :finger => 1, :function => :fifth
      mark :string => 2, :fret => 3, :finger => 3, :function => :root
      mark :string => 1, :fret => 2, :finger => 2, :function => :third
    end    
  end
  
  Fretboards.add(self.name, "C") do
    ::Fretboards::Fretboard.new(:strings => 6, :fret_start => 0, :fret_end => 4, :position => :absolute) do
      mark :string => 6, :fret => :x
      mark :string => 5, :fret => 3, :finger => 3, :function => :root
      mark :string => 4, :fret => 2, :finger => 2, :function => :third
      mark :string => 3, :fret => 0, :function => :fifth
      mark :string => 2, :fret => 1, :finger => 1, :function => :root
      mark :string => 1, :fret => 0, :function => :third
    end    
  end
  

end