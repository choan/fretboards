$: << "lib"
require "rake/clean"


require "fretboards"
require "fretboards/ukulele"
require "fretboards/ukulele/chords"
require "fretboards/ukulele/arpeggios"
require "fretboards/ukulele/scales"



OUTPUT_DIR = "out"
OUTPUT_DIR_PNG = File.join OUTPUT_DIR, "png"
OUTPUT_DIR_SVG = File.join OUTPUT_DIR, "svg"
OUTPUT_DIR_TIFF = File.join OUTPUT_DIR, "tif"

# TODO can we autodetect or force the .jar to be already in the classpath?
BATIK_JAR = "~/classpath/batik-1.7/batik-rasterizer.jar"

PNG_WIDTH  = 150
PNG_HEIGHT = 200
PNG_DPI    = 72

TIFF_WIDTH  = 300
TIFF_HEIGHT = 400
TIFF_DPI    = 300

CLEAN.include OUTPUT_DIR

directory OUTPUT_DIR
directory OUTPUT_DIR_SVG
directory OUTPUT_DIR_TIFF
directory OUTPUT_DIR_PNG

task :default => :raster_all

task :raster_all => [:raster_svg, :raster_png, :raster_tiff]

desc "svg output"
task :raster_svg => [OUTPUT_DIR_SVG] do
  require "fretboards/renderers/svg"
  renderer = Fretboards::Renderers::Svg.new
  Fretboards.toc.each do |name|
    file_name = name.split("::")[1..-1].map { |s| s.gsub(/(.)([A-Z])/) {"#{$1}_#{$2.downcase}" } }.join("-").downcase + ".svg"
    File.open(File.join(OUTPUT_DIR_SVG, file_name), "w") do |f|
      f.puts renderer.render(Fretboards[name])
    end
  end
  
end

desc "png output"
task :raster_png => [ OUTPUT_DIR_PNG ] do
  sh "java -Dapple.awt.graphics.UseQuartz=false -jar #{BATIK_JAR} -w #{PNG_WIDTH} -h #{PNG_HEIGHT}  -dpi #{PNG_DPI} -bg 255.255.255.255 -d #{OUTPUT_DIR_PNG} #{OUTPUT_DIR_SVG}/*.svg"
end

desc "tiff output"
task :raster_tiff => [ OUTPUT_DIR_TIFF ] do
  sh "java -Dapple.awt.graphics.UseQuartz=false -jar #{BATIK_JAR} -m image/tiff -d #{OUTPUT_DIR_TIFF} -dpi #{TIFF_DPI} -bg 255.255.255.255 -w #{TIFF_WIDTH} -h #{TIFF_HEIGHT} #{OUTPUT_DIR_SVG}/*.svg"
end
