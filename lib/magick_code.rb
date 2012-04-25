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
        else
            ImageList.new(@file_location).scale(x_percent.to_f).write(File.basename(@file_location, File.extname(@file_location))+"_resized"+File.extname(@file_location))
        end
    end
end
