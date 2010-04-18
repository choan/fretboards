require "fretboards/ukulele"

module Fretboards::Ukulele::Scales; end

Dir[File.join(File.dirname(__FILE__), "scales", "*.rb")].each { |f| load f }
