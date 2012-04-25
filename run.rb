require 'RMagick'
require 'lib/magick_code'
include Magick
scale, *images=ARGV
if (scale==nil||images==[])
    puts "Usage instruction : ruby -I . run.rb percentage_to_scale_to location_of_image_or_directory"
    raise ArgumentError, "Wrong number of arguments!"
end
images.each do |file_name| 
    STDERR.puts "Now processing #{file_name}"
    MagickClass.new(file_name).scale_to(scale)
end
puts "DONE!"
puts "Created by: Ankur Goel"
puts "ankurgel@gmail.com"
puts "http://twitter.com/AnkurGel"
