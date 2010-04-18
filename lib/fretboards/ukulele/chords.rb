require "fretboards/ukulele"

module Fretboards::Ukulele::Chords; end

Dir[File.join(File.dirname(__FILE__), "chords", "*.rb")].each { |f| load f }
