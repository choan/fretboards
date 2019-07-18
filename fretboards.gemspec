# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'fretboards/version'

Gem::Specification.new do |s|
  s.name        = 'fretboards'
  s.version     = Fretboards::VERSION
  s.authors     = ['Choan Galvez']
  s.email       = ['choan.galvez@gmail.com']
  s.licenses    = ['MIT']
  s.homepage    = ''
  s.summary     = 'Define and draw fretboards'
  s.description = 'Allows defining instrument fretboard structures and representing them as highly customizable SVG graphics.'

  s.rubyforge_project = "fretboards"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "builder"
end
