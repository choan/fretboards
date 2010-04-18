module Fretboards::Ukulele::Scales::MinorPentatonic
  
  Fretboards.add(self.name, "first_position") do
    Fretboards::Fretboard.new(:strings => 4, :fret_start => 1, :fret_end => 5, :position => :relative) do
      mark :string => 4, :fret => 1, :symbol => :root
      mark :string => 4, :fret => 4
      mark :string => 3, :fret => 1
      mark :string => 3, :fret => 3
      mark :string => 2, :fret => 2
      mark :string => 2, :fret => 4, :symbol => :root
      mark :string => 1, :fret => 2
      mark :string => 1, :fret => 4
    end
  end

  Fretboards.add(self.name, "second_position") do
    Fretboards::Fretboard.new(:strings => 4, :fret_start => 1, :fret_end => 5, :position => :relative) do
      mark :string => 4, :fret => 2
      mark :string => 4, :fret => 4
      mark :string => 3, :fret => 1
      mark :string => 3, :fret => 4
      mark :string => 2, :fret => 2, :symbol => :root
      mark :string => 2, :fret => 5
      mark :string => 1, :fret => 2
      mark :string => 1, :fret => 4
    end
  end

  Fretboards.add(self.name, "third_position") do
    Fretboards::Fretboard.new(:strings => 4, :fret_start => 1, :fret_end => 5, :position => :relative) do
      mark :string => 4, :fret => 2
      mark :string => 4, :fret => 4
      mark :string => 3, :fret => 2
      mark :string => 3, :fret => 4, :symbol => :root
      mark :string => 2, :fret => 3
      mark :string => 2, :fret => 5
      mark :string => 1, :fret => 2
      mark :string => 1, :fret => 5
    end
  end
  
  Fretboards.add(self.name, "fourth_position") do
    Fretboards::Fretboard.new(:strings => 4, :fret_start => 1, :fret_end => 5, :position => :relative) do
      mark :string => 4, :fret => 1
      mark :string => 4, :fret => 4
      mark :string => 3, :fret => 1, :symbol => :root
      mark :string => 3, :fret => 4
      mark :string => 2, :fret => 2
      mark :string => 2, :fret => 4
      mark :string => 1, :fret => 2
      mark :string => 1, :fret => 4, :symbol => :root
    end
  end
  
  Fretboards.add(self.name, "fifth_position") do
    Fretboards::Fretboard.new(:strings => 4, :fret_start => 1, :fret_end => 5, :position => :relative) do
      mark :string => 4, :fret => 2
      mark :string => 4, :fret => 4, :symbol => :root
      mark :string => 3, :fret => 2
      mark :string => 3, :fret => 4
      mark :string => 2, :fret => 2
      mark :string => 2, :fret => 5
      mark :string => 1, :fret => 2, :symbol => :root
      mark :string => 1, :fret => 5
    end
  end

end

