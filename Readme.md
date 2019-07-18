# Fretboards

Fretboards is a Ruby library to programatically define fretboard diagrams of string instruments and render them to SVG and other formats.


## Installation

This package is available in RubyGems and can be installed with:

    gem install fretboards

For users working with the source from GitHub, you can run:

    rake install

Which will build and install the gem (you may need sudo/root permissions). You can also chose to build the gem manually if you want:

    rake build


## Usage

```ruby
require 'fretboards'

# initialize the fretboard with a set tuning
# number of strings is taken from the tuning
fb = Fretboards::Fretboard.new(tuning: Fretboards::Tuning::UKULELE)

# use the `terse` method for adding marks
# marks are passed as an array and added sequentially
# from bottom to first string
fb.terse(%w{ 1 2 1 1 })

# use an opening square bracket to signal the top string of a barre
fb.terse(%w{ 1[ 2 1 1 })

# use an exclamation mark on any of the dots to set it as featured (root, i.e.)
fb.terse(%w{ 1[ 2 1 1! })

# fingerings ar preceded by a `-`
fb.terse(%w{ 1-1 2-3 1-2 3-4 })

# use a renderer subclass to turn the definition into a representation
# the task of getting the output into a file is up to the library user
renderer = Fretboards::Renderer::Svg.new
renderer.render(fb)
```


## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.


## License

This project is licensed under the MIT license, a copy of which can be found in the LICENSE.txt file.


## Support

Users looking for support should file an issue on the GitHub issue tracking page (https://github.com/choan/fretboards/issues), or file a pull request (https://github.com/choan/fretboards/pulls) if you have a fix available.

Those who wish to contribute directly to the project can contact me at <choan.galvez@gmail.com> to talk about getting repository access granted.