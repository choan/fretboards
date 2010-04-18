require "fretboards/ukulele"

module Fretboards::Ukulele::Arpeggios; end

Dir[File.join(File.dirname(__FILE__), "arpeggios", "*.rb")].each { |f| load f }
