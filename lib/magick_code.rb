require "RMagick"
require 'fileutils'
include Magick

class MagickClass
    @@image_ext=%w[png jpg jpeg gif bmp timff].map{|x| "."+x}
    attr_accessor :filesdetected, :parent_dir, :dir_location
    @@fol=[]

    def initialize(string)
        if File.extname(string).size>1
            @filesdetected=File.expand_path(string)
        else
            @parent_dir=File.expand_path(string)
            @filesdetected=[]
            @dir_location=File.dirname(string)
            extract_files
        end
    end
    def extract_files
        Dir.chdir(@parent_dir)
        @@image_ext.each do |file_extension|
            @filesdetected<<Dir['**/*'+file_extension]
        end
        @filesdetected.flatten!
        @@fol=filesdetected.select{|x| x=~/\//}.sort_by{|x| x.count('/')}.reverse.map{|x| File.split(x)[0]}.uniq
    end

    def scale_to(x_percent)
        if (dir_location==nil)
            puts "Working wih #{@filesdetected}"
            raise TypeError,'Not supported image file' unless @@image_ext.include?(File.extname(@filesdetected))
            Dir.chdir(File.split(filesdetected)[0])
            ImageList.new(@filesdetected).scale(x_percent.to_f/100).write(File.basename(@filesdetected, File.extname(@filesdetected))+"_resized"+File.extname(@filesdetected))
            output="Output File: #{File.basename(filesdetected,File.extname(filesdetected) )}_resized#{File.extname(filesdetected)} in #{File.split(filesdetected)[0]}"
        else
            Dir.mkdir(parent_dir+"_resized")
            createdirectory_framework
            @filesdetected.each do |img|
                puts "Processing #{img}.. Please wait.. "
                ImageList.new(img).scale(x_percent.to_f/100).write(File.expand_path(img, parent_dir+"_resized"))
            end
            output="Image resized to #{x_percent} percent and lovingly stacked in #{parent_dir}_resized! Thank me NAO!"
        end
        puts output
    end
    def createdirectory_framework
        Dir.chdir(parent_dir+"_resized")
        @@fol.each do |folder|
            if !(File.directory?(folder))
                FileUtils.mkdir_p(folder)
#                %x(mkdir -p #{folder})
            end
        end
        Dir.chdir(parent_dir)
    end
end
