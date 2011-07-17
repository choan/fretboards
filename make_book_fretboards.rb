#!/usr/bin/env ruby

require "rubygems"
require "yaml"
require "lib/fretboards/fretboard"
require "lib/fretboards/renderers/svg"
require "lib/fretboards/renderers/png"

require "pp"
data = YAML.load_file("data.yaml")

r = Fretboards::Renderers::Png.new

data.each do |key, value|
  
  fb = Fretboards::Fretboard.from_s(value)
  # puts fb
  r.render(fb, :output_filename => "out/#{key}.png", :height => 150, :width => 150)
end