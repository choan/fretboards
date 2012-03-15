Gem::Specification.new do |s|
  s.name = 'fretboards'
  s.version = '0.0.1'
  s.date = '2012-03-15'
  s.summary = 'Define and draw fretboards'
  s.description = 'Allows defining instrument fretboard structures and representing them as highly customizable SVG graphics.'
  s.authors = ['Choan Gálvez']
  s.email = 'choan.galvez@gmail.com'
  s.files = [
    'lib/fretboards.rb',
    'lib/fretboards/fretboard.rb',
    'lib/fretboards/fretboard_collection.rb',
    'lib/fretboards/pitch.rb',
    'lib/fretboards/renderer/base.rb',
    'lib/fretboards/renderer/svg.rb',
    'lib/fretboards/ext/hash.rb',
    'bin/fretboards_render',
    ]
  s.homepage = 'http://github.com/choan/fretboards/'
  
  s.add_runtime_dependency 'builder', '~> 3.0'
  
  s.test_files = Dir.glob('test/test_*.rb')
  
end