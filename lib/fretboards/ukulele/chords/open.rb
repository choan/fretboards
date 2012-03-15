module Fretboards::Ukulele::Chords::Open
  
  
  Fretboards.add(self.name, "C") do
    ::Fretboards::Fretboard.new(:strings => 4, :fret_start => 0, :fret_end => 4, :position => :absolute) do
      mark :string => 4, :fret => 0, :function => :p5
      mark :string => 3, :fret => 0, :function => :root
      mark :string => 2, :fret => 0, :function => :maj3
      mark :string => 1, :fret => 3, :finger => 3, :function => :root
    end    
  end
  
  Fretboards.add(self.name, "Db") do
    ::Fretboards::Fretboard.new(:strings => 4, :fret_start => 0, :fret_end => 4, :position => :absolute) do
      mark :string => 4, :fret => 1, :finger => 1, :function => :p5
      mark :string => 3, :fret => 1, :finger => 1, :function => :root
      mark :string => 2, :fret => 1, :finger => 1, :function => :maj3
      mark :string => 1, :fret => 4, :finger => 4, :function => :root
    end    
  end
  
  Fretboards.add(self.name, "Eb") do
    Fretboards['Fretboards::Ukulele::Chords::Open::Db'].transpose(2, :fret_start => 3, :fret_end => 6) do
      label_fret 3
    end
  end
  
  Fretboards.add(self.name, "C7b9") do
    ::Fretboards::Fretboard.new(:strings => 4, :fret_start => 0, :fret_end => 4, :position => :absolute) do
      mark :string => 4, :fret => 3, :function => :b7
      mark :string => 3, :fret => 4, :function => :maj3
      mark :string => 2, :fret => 3, :function => :p5
      mark :string => 1, :fret => 4, :function => :b9
    end    
  end
  
  Fretboards.add(self.name, "C-6") do
    ::Fretboards::Fretboard.new(:strings => 4, :fret_start => 0, :fret_end => 4, :position => :absolute) do
      mark :string => 4, :fret => 2, :function => :maj6
      mark :string => 3, :fret => 3, :function => :b3
      mark :string => 2, :fret => 3, :function => :p5
      mark :string => 1, :fret => 3, :function => :root
    end    
  end
  
  Fretboards.add(self.name, "Db6") do
    ::Fretboards::Fretboard.new(:strings => 4, :fret_start => 0, :fret_end => 4, :position => :absolute) do
      mark :string => 4, :fret => 1, :function => :p5
      mark :string => 3, :fret => 1, :function => :root
      mark :string => 2, :fret => 1, :function => :maj3
      mark :string => 1, :fret => 1, :function => :maj6
    end    
  end
  
  Fretboards.add(self.name, "D-7b5") do
    ::Fretboards::Fretboard.new(:strings => 4, :fret_start => 0, :fret_end => 4, :position => :absolute) do
      mark :string => 4, :fret => 1, :function => :b5
      mark :string => 3, :fret => 2, :function => :root
      mark :string => 2, :fret => 1, :function => :b3
      mark :string => 1, :fret => 3, :function => :b7
    end    
  end
  
  Fretboards.add(self.name, "F") do 
    ::Fretboards::Fretboard.new(:strings => 4, :fret_start => 0, :fret_end => 4, :position => :absolute) do
      mark :string => 4, :fret => 2, :finger => 2, :function => :maj3
      mark :string => 3, :fret => 0, :function => :p5
      mark :string => 2, :fret => 1, :finger => 1, :function => :root
      mark :string => 1, :fret => 0, :function => :maj3
    end
  end
  
  Fretboards.add(self.name, "G") do 
    ::Fretboards::Fretboard.new(:strings => 4, :fret_start => 0, :fret_end => 4, :position => :absolute) do
      mark :string => 4, :fret => 0, :function => :root
      mark :string => 3, :fret => 2, :finger => 1, :function => :p5
      mark :string => 2, :fret => 3, :finger => 3, :function => :root
      mark :string => 1, :fret => 2, :finger => 2, :function => :maj3
    end
  end

  Fretboards.add(self.name, "G-7b5") do 
    ::Fretboards::Fretboard.new(:strings => 4, :fret_start => 0, :fret_end => 4, :position => :absolute) do
      mark :string => 4, :fret => 0, :function => :root
      mark :string => 3, :fret => 1, :finger => 1, :function => :b5
      mark :string => 2, :fret => 1, :finger => 3, :function => :b7
      mark :string => 1, :fret => 1, :finger => 2, :function => :b3
    end
  end

  

  Fretboards.add(self.name, "A") do 
    ::Fretboards::Fretboard.new(:strings => 4, :fret_start => 0, :fret_end => 4, :position => :absolute) do
      mark :string => 4, :fret => 2, :finger => 2, :function => :root
      mark :string => 3, :fret => 1, :finger => 1, :function => :third
      mark :string => 2, :fret => 0, :function => :fifth
      mark :string => 1, :fret => 0, :function => :root
    end
  end

end