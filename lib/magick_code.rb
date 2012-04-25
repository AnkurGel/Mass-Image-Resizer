require "RMagick"
include Magick

class MagickClass
    @@image_ext=%w[png jpg jpeg gif bmp timff].map{|x| "."+x}
    attr_accessor :filesdetected, :parent_dir, :dir_location

    def initialize(string)
        if File.extname(string).size>1
            @filedetected=string
        else
            @parent_dir=string
            @filesdetected=[]
            @dir_location=File.dirname(string)
            extract_files
        end
    end
    def extract_files
        Dir.chdir(@parent_dir)
        @@image_ext.each do |file_extension|
            @filesdetected<<Dir['*'+file_extension]
        end
        @filesdetected.flatten!

    end

    def scale_to(x_percent)
        if (dir_location==nil)
            ImageList.new(@filedetected).scale(x_percent.to_f).write(File.basename(@filedetected, File.extname(@filedetected))+"_resized"+File.extname(@filedetected))
            output="Output File: #{filesdetected}_resized"
        else
            Dir.mkdir(parent_dir+"_resized")
            @filesdetected.each do |img|
                puts "Processing #{img}.. Please wait.. "
                ImageList.new(img).scale(x_percent.to_f).write(File.expand_path(img, parent_dir+"_resized"))
            end
            output="Image resized to #{x_percent} percent and stacked in #{parent_dir}_resized"
        end
        puts output
    end
end
