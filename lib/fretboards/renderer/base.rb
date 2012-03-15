module Fretboards
  module Renderer
    class Base
      def render(fb)
        # TODO warn that this method should be extended
      end
      
      def option(name, value)
        @opts[name] = value
      end
    end
  end
end