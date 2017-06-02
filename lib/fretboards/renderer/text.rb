require 'fretboards/renderer/base'

module Fretboards
  module Renderer
    class Text < Base
      
      def render(fb)
        @fb = fb
        output_marks = []
        @fb.string_count.downto(1).each do |n|
          mark = fb.marks.find { |m| m[:string] == n && m[:symbol] != :phantom }
          output_marks << (!mark.nil? ? mark[:fret] : "x" )
        end
        output = output_marks.join(" ")
      end
      
    end
  end
end
