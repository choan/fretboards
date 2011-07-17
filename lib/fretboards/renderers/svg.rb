module Fretboards::Renderers
  class Svg
    
    def initialize(options = {})
      @opts = {
        :show_fingering => true,
        :show_functions => true,
      }.update(options)
    end
    
    def function_symbol_to_s(sym)
      {
        :p5 => "5",
        :maj3 => "3",
        :root => "1",
        :b3 => "♭3",
        :b5 => "♭5",
        :b7 => "♭7",
        :maj7 => "7",
        :p6 => "6",
        :aug5 => "♯5",
        :maj9 => "9",
        :b9 => "♭9",
      }[sym] || sym.to_s
    end
    
    def render(fretboard)
      require "builder"
      nut_attrs  = { :"stroke-width" => 3, :stroke => "#222" }
      line_attrs = { :"stroke-width" => 1, :stroke => "#222" }
      circle_attrs = { :"stroke-width" => 1, :stroke => "#000", :fill => "#000", :r => 6 }
      root_attrs = { :fill => "#ddd", :stroke => "#000"}
      function_attrs = { :"text-anchor" => "middle", :fill => "#000", :"font-size" => 8 }
      finger_attrs = { :"text-anchor" => "middle", :fill => "#fff", :"font-weight" => "bold", :"font-size" => 12 }
      phantom_root_attrs = { :fill => "#ddd", :stroke => "#333", :r => 4 }
      xml = ::Builder::XmlMarkup.new(:indent => 2)
      xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
      n_strings = fretboard.strings
      string_spacing = fretboard.strings == 4 ? 20 : 15
      fret_spacing = 20
      padding = 10
    
      canvas_height = 20 + fretboard.fret_end * 20
      canvas_width = (fretboard.strings - 1) * string_spacing + padding * 2

      xml.svg(:viewBox => "0 0 #{canvas_width} #{canvas_height}", :version => "1.1",
           :xmlns => "http://www.w3.org/2000/svg") do |svg|
      
      
        # Vertical lines
        # TODO accept any number of strings
        (0..n_strings-1).each do |string|
          x = 10 + string * string_spacing
          y1 = 10
          y2 = 10 + fretboard.fret_end * fret_spacing
          svg.line(line_attrs.merge(:x1 => x, :x2 => x, :y1 => y1, :y2 => y2))
        end
        
        # Horizontal lines
        # TODO accept any range of frets
        (0..fretboard.fret_end).each do |fret|
          # fret = fret - fretboard.fret_start
          x1 = padding
          x2 = canvas_width - padding
          y = padding + fret * fret_spacing
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

        (1..fretboard.strings).each do |string|
          # Open strings
          if m = fretboard.marks.find { |m| m[:fret] == 0 && m[:string] == string }
            attrs = { :r => 3, :"stroke-width" => 1, :stroke => "#000", :fill => "none", :cy => 3, :cx => canvas_width - padding - (string - 1) * string_spacing }
            svg.circle attrs;
          end
          # Muted strings
          if m = fretboard.marks.find { |m| m[:fret] == :x && m[:string] == string }
            attrs = { :align => 'TODO', :y => 6, :x => canvas_width - padding - (string - 1) * string_spacing }
            svg.text 'X', attrs
          end
        end
        

        
        # Dots
        start = fretboard.fret_start == 0 ? 1 : fretboard.fret_start
        (start..fretboard.fret_end).each do |fret_number|
          (1..fretboard.strings).each do |string_number|
            if m = fretboard.marks.find { |m| m[:fret] == fret_number && m[:string] == string_number }
              cx = canvas_width - padding - (string_number - 1) * string_spacing
              cy = 20 + (fret_number - 1) * fret_spacing
              attrs = circle_attrs.merge(:cx => cx, :cy => cy)
              if m[:symbol] == :root
                attrs = attrs.merge(root_attrs)
              elsif m[:symbol] == :phantom_root
                attrs = attrs.merge(phantom_root_attrs)
              end
              svg.circle(attrs)
              attrs = finger_attrs.merge(:y => cy + 4, :x => cx)
              if @opts[:show_fingering] && m[:finger]
                svg.text m[:finger], attrs
              end
            end
          end
        end
        
        # Functions
        if @opts[:show_functions]
          (1..fretboard.strings).each do |string|
            attrs = function_attrs.merge(:y => canvas_height, :x => canvas_width - padding - (string - 1) * string_spacing )
            if (m = fretboard.marks.find { |m| m[:string] == string}) && m[:function]
              svg.text(function_symbol_to_s(m[:function]), attrs)
            end
          end
        end
        
      end
      # xml
      
    end
    
    
  end
  
end