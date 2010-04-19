module Fretboards::Renderers
  class Svg
    
    def initialize(options = {})
    end
    
    def render(fretboard)
      require "builder"
      nut_attrs  = { :"stroke-width" => 3, :stroke => "#333" }
      line_attrs = { :"stroke-width" => 1, :stroke => "#333" }
      circle_attrs = { :"stroke-width" => 1, :stroke => "#000", :fill => "#333", :r => 6 }
      root_attrs = { :fill => "#f00" }
      xml = ::Builder::XmlMarkup.new(:indent => 2)
      xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
    
      xml.svg(:viewBox => "0 0 80 120", :version => "1.1",
           :xmlns => "http://www.w3.org/2000/svg") do |svg|
      
      
        # Vertical lines
        # TODO accept any number of strings
        (0..3).each do |string|
          x = 10 + string * 20
          y1 = 10
          y2 = 10 + fretboard.fret_end * 20
          svg.line(line_attrs.merge(:x1 => x, :x2 => x, :y1 => y1, :y2 => y2))
        end
        
        # Horizontal lines
        # TODO accept any range of frets
        (0..fretboard.fret_end).each do |fret|
          x1 = 10
          x2 = 70
          y = 10 + fret * 20
          attrs = line_attrs.merge(:x1 => x1, :x2 => x2, :y1 => y, :y2 => y)
          # nut
          if fret == 0 && fretboard.fret_start == 0
            attrs = attrs.merge(nut_attrs)
            attrs[:y1] -= 1
            attrs[:y2] -= 1
            attrs[:x1] -= 1
            attrs[:x2] += 1
          end
          svg.line(attrs)
        end

        # Open strings
        (1..fretboard.strings).each do |string|
          if m = fretboard.marks.find { |m| m[:fret] == 0 && m[:string] == string }
            attrs = { :r => 3, :"stroke-width" => 1, :stroke => "#000", :fill => "none", :cy => 4, :cx => 70 - (string - 1) * 20 }
            svg.circle attrs;
          end
        end
        

        
        # Dots
        start = fretboard.fret_start == 0 ? 1 : fretboard.fret_start
        (start..fretboard.fret_end).each do |fret_number|
          (1..fretboard.strings).each do |string_number|
            if m = fretboard.marks.find { |m| m[:fret] == fret_number && m[:string] == string_number }
              attrs = circle_attrs.merge(:cx => 70 - (string_number - 1) * 20, :cy => 20 + (fret_number - 1) * 20)
              if m[:symbol] == :root
                attrs = attrs.merge(root_attrs)
              end
              svg.circle(attrs)
            end
          end
        end
        
      end
      # xml
      
    end
    
    
  end
  
end