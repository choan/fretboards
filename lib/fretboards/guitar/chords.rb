require "fretboards/guitar"

module Fretboards::Guitar::Chords; end

Dir[File.join(File.dirname(__FILE__), "chords", "*.rb")].each { |f| load f }
