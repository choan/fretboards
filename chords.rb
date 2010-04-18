$: << "lib"
require "rubygems"
require "fretboards"
require "fretboards/ukulele/chords"
require "fretboards/renderers/svg"


# Fretboards.add("Ukulele::Chords::MinorSeventh::root_fourth") do 
#   ::Fretboards::Fretboard.new(:strings => 4, :fret_start => 1, :fret_end => 5, :position => :relative) do
#     mark(:string => 4) { mark :fret => 2, :symbol => :root }
#     mark(:string => 3) { mark :fret => 4 }
#     mark(:string => 2) { mark :fret => 3 }
#     mark(:string => 1) { mark :fret => 3 }
#   end
# end

puts Fretboards.toc

# renderer = Fretboards::Renderers::Svg.new
# 
# puts renderer.render(Fretboards["Ukulele::Chords::MinorSeventh::root_fourth"])

# %w[root_fourth root_second root_third root_first].each do |n|
  
  
#   File.open("out/m7_#{n}.svg", "w") do |f|
#     f.puts renderer.render(Fretboards::Ukulele::Chords::MinorSeventh.send(n))
#   end
#   
# end

# puts Fretboards::Renderers::Svg.new.render(Fretboards::Ukulele::Chords::MinorSeventh.root_fourth)


# puts Fretboards::Ukulele::Arpeggios::MinorSeventh.first_position
# puts Fretboards::Ukulele::Arpeggios::MinorSeventh.second_position
# puts Fretboards::Ukulele::Arpeggios::MinorSeventh.third_position
# puts Fretboards::Ukulele::Arpeggios::MinorSeventh.fourth_position
# puts Fretboards::Ukulele::Arpeggios::MinorSeventh.fifth_position
# 
# puts Fretboards::Ukulele::Arpeggios::Seventh.first_position
# puts Fretboards::Ukulele::Arpeggios::Seventh.second_position
# puts Fretboards::Ukulele::Arpeggios::Seventh.third_position
