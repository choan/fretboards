module Fretboards::Ukulele::Chords::Seventh
  
  
  
  Fretboards.add(self.name, "root_fourth") do 
    ::Fretboards::Fretboard.new(:strings => 4, :fret_start => 1, :fret_end => 5, :position => :relative) do
      mark(:string => 4) { mark :fret => 2, :symbol => :root }
      mark(:string => 3) { mark :fret => 4 }
      mark(:string => 2) { mark :fret => 3 }
      mark(:string => 1) { mark :fret => 4 }
    end
  end


  Fretboards.add(self.name, "root_second") do
    ::Fretboards::Fretboard.new(:strings => 4, :fret_start => 1, :fret_end => 5, :position => :relative) do
      mark :string => 4, :fret => 3
      mark :string => 3, :fret => 4
      mark :string => 2, :fret => 2, :symbol => :root
      mark :string => 1, :fret => 4
    end
  end

  Fretboards.add(self.name, "root_third") do
    ::Fretboards::Fretboard.new(:strings => 4, :fret_start => 1, :fret_end => 5, :position => :relative) do
      mark :string => 4, :fret => 3
      mark :string => 3, :fret => 3, :symbol => :root
      mark :string => 2, :fret => 3
      mark :string => 1, :fret => 4
    end
  end

  Fretboards.add(self.name, "root_first") do
    ::Fretboards::Fretboard.new(:strings => 4, :fret_start => 1, :fret_end => 5, :position => :relative) do
      mark :string => 4, :fret => 2
      mark :string => 3, :fret => 3
      mark :string => 2, :fret => 2
      mark :string => 1, :fret => 2, :symbol => :root
    end
  end

end