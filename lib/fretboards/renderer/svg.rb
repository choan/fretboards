require "fretboards/renderer/base"
require "fretboards/ext/hash"

module Fretboards
  module Renderer
    class Svg < Base
      
      def initialize(opts = {})
        # TODO configuration should merge recursively
        @opts = {
          :string_attrs => { :"stroke-width" => 1, :stroke => "#222" },
          :fret_attrs => { :"stroke-width" => 1, :stroke => "#222", :"stroke-linecap" => "round" },
          :rectangular_fret_attrs => { :height => 1.5, :fill => "#666", :stroke => "#666", :"stroke-width" => 1, :rx => 1, :ry => 1 },
          :nut_attrs => { :"stroke-width" => 5, :stroke => "#222", :"stroke-linecap" => "round"},
          :dot_attrs => { :fill => "#000", :r => 8 },
          :open_attrs => { :"stroke-width" => 1, :stroke => "#000", :fill => "#fff", :r => 3 },
          :open_root_symbol_attrs => { :"stroke-width" => 2, :r => 3 },
          :open_phantom_root_symbol_attrs => { :"stroke-width" => 1, :r => 3, :"stroke-dasharray" => "1 1" },
          :svg_attrs => { :xmlns => "http://www.w3.org/2000/svg", :version => "1.1" },
          :in_dot_attrs => { :"text-anchor" => "middle", :fill => "#fff", :"font-weight" => "normal", :"font-size" => 10, :"font-family" => "sans-serif", :"font-weight" => "bold"},
          :in_dot_root_symbol_attrs => { :fill => "#000", :"font-weight" => "bold" },
          :in_bottom_attrs => { :"text-anchor" => "middle", :fill => "#000", :"font-weight" => "normal", :"font-size" => 8, :"font-family" => "sans-serif" },
          :label_attrs => { :"text-anchor" => "end", :fill => "#000", :"font-size" => 10, :"font-family" => 'sans-serif' },
          :root_symbol_attrs => { :fill => "#fff", :stroke => "#000", :r => 7, :"stroke-width" => 2 },
          :phantom_root_symbol_attrs => { :fill => "#fff", :stroke => "#333", :r => 7, :"stroke-width" => 1, :"stroke-dasharray" => "1 1" },
          :title_attrs => { :"text-anchor" => "middle", :fill => "#000", :"font-weight" => "bold", :"font-size" => 18, :"font-family" => "sans-serif" } ,
          :mute_attrs => { :stroke => "#000"},
          :barre_attrs => { :height => 20, :stroke => "#000", :fill => "#fff", :rx => 9, :ry => 9 },
          :group_attrs => { },
          :in_dot => :finger,
          :in_bottom => :function,
          :padding_left => 20,
          :padding_right => 15,
          :padding_top => 30,
          :padding_bottom => 20,
          :height => 180,
          :width => 108,
          :string_ext_bottom => 5,
          :string_ext_top => 5,
          :fret_ext_left => 2,
          :fret_ext_right => 2,
          :string_widths => [ 2, 2, 2, 2 ], # TODO calculate on demand if not passed
          :fret_reduction_factor => 0.95,
          :rectangular_frets => true,
          :fret_count => 4,
          :show_labels => true,
          :show_title => true,
          :open_margin_bottom => 4,
        }.deep_merge(opts)
      end
      
      def render(fb)
        @fb = fb
        require "builder"
        xml = ::Builder::XmlMarkup.new(:indent => 2)
        xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
        view_box = [ @opts[:width], @opts[:height] ]
        view_box = view_box.reverse if @opts[:landscape]
        xml.svg(@opts[:svg_attrs].merge(:viewBox => "0 0 #{view_box.join(' ')}")) do |svg|
          svg.g(@opts[:group_attrs]) do
            svg.g(landscape_attributes) do
              draw_title(svg) unless @opts[:show_title] == false
              draw_frets(svg)
              draw_strings(svg)
              draw_barres(svg)
              draw_marks(svg)
              draw_in_dots(svg, @opts[:in_dot]) if @opts[:in_dot]
              draw_in_bottom(svg, @opts[:in_bottom]) if @opts[:in_bottom]
              draw_labels(svg) unless @opts[:show_labels] == false
              # draw_open(svg)
              draw_mutes(svg)
            end
          end
       end
        # @svg
        # xml
      end
      
      def landscape_attributes
        if @opts[:landscape]
          {
            :transform => "rotate(-90 #{@opts[:width]} 0) translate(0 -#{@opts[:width]})"
          }
        else
          {}
        end
      end
      
      def string_attrs
        @opts[:string_attrs]
      end
      
      def fret_attrs
        @opts[:fret_attrs]
      end
      
      def nut_attrs
        @opts[:nut_attrs]
      end
      
      def string_spacing
        (@opts[:width] - @opts[:padding_left] - @opts[:padding_right]) / (@fb.string_count - 1)
      end
      
      def draw_strings(svg)
        (0..@fb.string_count-1).each do |sn|
          # x = @opts[:padding_left] + sn * string_spacing(fb)
          x = get_string_x(@fb.index_to_string_number(sn))
          y1 = @opts[:padding_top]
          y2 = @opts[:height] - @opts[:padding_bottom]
          attrs = string_attrs.merge(:x1 => x, :x2 => x, :y1 => y1, :y2 => y2)
          if (!@opts[:string_widths].empty?) 
            attrs = attrs.merge({ :"stroke-width" => @opts[:string_widths][sn] })
          end
          svg.line(attrs)
        end
      end
      
      def draw_title(svg)
        # TODO calculate ideal gap
        gap = 15
        svg.text(@fb.title, { :x => @opts[:width] * 0.5, :y => @opts[:padding_top] - gap }.merge(@opts[:title_attrs]))
      end
      
      def get_string_x(sn)
        sn = @fb.string_number_to_index(sn)
        @opts[:padding_left] + sn * string_spacing
      end
      
      def draw_frets(svg)
        fret_range = @fb.fret_range(@opts[:fret_count])
        total_frets = fret_range.last - fret_range.first
        total_frets += 1 if (fret_range.first == 1)
        # nut / first line
        if fret_range.first == 1
          draw_nut(svg)
        else
          draw_fret(svg, 0)
        end
        total_frets.times do |n|
          draw_fret(svg, n+1)
        end
      end
      
      def draw_labels(svg)
        fret_range = @fb.fret_range(@opts[:fret_count])
        if fret_range.first > 1
          y = get_dot_position(0, fret_range.first)[1] + @opts[:label_attrs][:"font-size"] * 0.4
          x = @opts[:padding_left] - @opts[:label_attrs][:"font-size"] * 1.25
          # TODO allow rotating
          svg.text(fret_range.first, { :y => y, :x => x }.merge(@opts[:label_attrs]))
        end
      end
      
      def draw_fret(svg, n)
        y = get_fret_y(n)
        if @opts[:rectangular_frets]
          svg.rect({ :y => y - 1.25, :x => @opts[:padding_left] - @opts[:fret_ext_left], :width => @opts[:width] - @opts[:padding_left] - @opts[:padding_right] + @opts[:fret_ext_left] + @opts[:fret_ext_right] }.merge(@opts[:rectangular_fret_attrs]))
        else
          svg.line(fret_attrs.merge(:x1 => @opts[:padding_left], :x2 => @opts[:width] - @opts[:padding_right], :y1 => y, :y2 => y))
        end
      end
      
      def draw_nut(svg)
        y = @opts[:padding_top] - @opts[:nut_attrs][:"stroke-width"] * 0.5
        extra_first = 0 # @opts[:string_widths][0] * 0.5
        extra_last = 0 # @opts[:string_widths].last * 0.5
        svg.line(nut_attrs.merge(:x1 => @opts[:padding_left] - extra_first, :x2 => @opts[:width] - @opts[:padding_right] + extra_last, :y1 => y, :y2 => y))
      end
      
      def get_fret_y(fret_number)
        fret_range = @fb.fret_range(@opts[:fret_count])
        avail = @opts[:height] - @opts[:padding_top] - @opts[:padding_bottom] - @opts[:string_ext_bottom]
        avail -= @opts[:string_ext_top] if (fret_range.first != 1)
        total_frets = fret_range.last - fret_range.first
        total_frets += 1 if (fret_range.first == 1)
        start = @opts[:padding_top]
        start += @opts[:string_ext_top] if (fret_range.first != 1)
        ff_size = get_first_fret_size(total_frets, @opts[:fret_reduction_factor], avail)
        # size_each = avail.to_f / total_frets
        # y = start
        y = (0..fret_number-1).inject(start) do |sum, f|
          sum + ff_size*@opts[:fret_reduction_factor]**f
        end
        y
      end
      
      def get_first_fret_size(gaps, factor, avail)
        sum = 0
        (0..gaps-1).each do |t|
          sum += factor**t
        end
        avail.to_f/sum.to_f
      end
      
      
      def draw_marks(svg)
        @fb.marks.each do |m|
          if m[:fret] == 0
            draw_open(svg, m)
          else
            x, y = *get_dot_position(m[:string], m[:fret])
            method_name = ("draw_" + m[:symbol].to_s + "_symbol").to_sym
            if m[:symbol] && self.respond_to?(method_name)
              self.send(method_name, svg, x, y, m)
            else
              draw_dot(svg, x, y, m)
            end
          end
        end
      end
      
      def draw_blue_note_symbol(svg, x, y, m)
        svg.rect(:x => x - 4, :y => y - 4, :width => 8, :height => 8, :fill => "#000", :stroke => "", :transform => "rotate(-45 #{x} #{y})")
        # svg.circle(:cx => x, :cy => y, :r => 3, :fill => "blue")
      end
      
      
      def draw_dot(svg, x, y, m)
        attrs = @opts[:dot_attrs].merge(:cx => x, :cy => y)
        attrs = attrs.merge(@opts[(m[:symbol].to_s + "_symbol_attrs").to_sym]) if (m[:symbol] && @opts[(m[:symbol].to_s + "_symbol_attrs").to_sym])
        svg.circle(attrs)
      end
      
      def get_dot_position(string, fret)
        fret_range = @fb.fret_range(@opts[:fret_count])
        diff = fret_range.first == 1 ? 0 : fret_range.first - 1
        fret -= diff
        x = get_string_x(string)
        y = 0.5 * (get_fret_y(fret - 1) + get_fret_y(fret))
        [x, y]
      end
      
      def draw_in_dots(svg, name)
        # TODO allow rotating dot text on rotated fretboards
        sym = name.to_sym
        sym_attrs = "in_dot_attrs".to_sym
        @fb.marks.each do |m|
          if m[sym] && m[:fret] > 0
            custom_attrs = ("in_dot_" + m[:symbol].to_s + "_symbol_attrs").to_sym
            x, y = *get_dot_position(m[:string], m[:fret])
            y += @opts[sym_attrs][:"font-size"] / 3.0
            attrs = @opts[sym_attrs]
            attrs = attrs.merge(@opts[custom_attrs]) if (m[:symbol] && @opts[custom_attrs])
            attrs = attrs.merge(:x => x, :y => y)
            svg.text(m[sym].to_s, attrs)
          end
        end
      end
      
      def draw_in_bottom(svg, name)
        # TODO allow rotating bottom text on rotated fretboards
        sym = name.to_sym
        sym_attrs = "in_bottom_attrs".to_sym
        @fb.marks.each do |m|
          if m[sym]
            x = get_string_x(m[:string])
            y = @opts[:height] - @opts[:padding_bottom] + @opts[:in_bottom_attrs][:"font-size"] * 1.5
            attrs = @opts[sym_attrs].merge(:x => x, :y => y)
            svg.text(m[sym].to_s, attrs)
          end
        end
      end
      
      def draw_open(svg, m)
        margin_bottom = @opts[:open_margin_bottom]
        y = @opts[:padding_top] - @opts[:open_attrs][:r] - @opts[:nut_attrs][:"stroke-width"] - margin_bottom
        x = get_string_x(m[:string])
        attrs = {:cx => x, :cy => y}.merge(@opts[:open_attrs])
        symbol_attrs = "open_#{m[:symbol]}_symbol_attrs".to_sym
        attrs = attrs.merge(@opts[symbol_attrs]) if (m[:symbol] && @opts[symbol_attrs])
        svg.circle(attrs)
      end
      
      def draw_mutes(svg)
        margin_bottom = @opts[:open_margin_bottom]
        cy = @opts[:padding_top] - @opts[:open_attrs][:r] - @opts[:nut_attrs][:"stroke-width"] - margin_bottom
        @fb.mutes.each do |s|
          delta = 3
          cx = get_string_x(s)
          svg.line({:x1 => cx - delta, :x2 => cx + delta, :y1 => cy - delta, :y2 => cy + delta}.merge(@opts[:mute_attrs]))
          svg.line({:x1 => cx - delta, :x2 => cx + delta, :y1 => cy + delta, :y2 => cy - delta}.merge(@opts[:mute_attrs]))
          # svg.text("x", { :x => cx, :y => cy })
        end
      end
      
      def draw_barres(svg)
        barre_attrs = @opts[:barre_attrs]
        @fb.barres.each do |b|
          dot_pos = get_dot_position(b[:from], b[:fret])
          w = get_string_x(b[:to]) - dot_pos[0] + barre_attrs[:height]
          x = dot_pos[0] - barre_attrs[:height] * 0.5
          y = dot_pos[1] - barre_attrs[:height] * 0.5
          svg.rect({:y => y, :x => x, :width => w}.merge(barre_attrs))
        end
      end
            
      
    end
  end
end