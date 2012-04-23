require 'RMagick'
include Magick
img=ImageList.new("zombie_resized.jpeg")
pixels=[]
pixels=img.export_pixels;pixelss=[]
pixels.each_slice(3){|x| pixelss<<x}
red=[]; green=[]; blue=[]
pixelss.each do |pixel|
	red<<pixel[0]<<0<<0; green<<0<<pixel[1]<<0; blue<<0<<0<<pixel[2]
end
p red.first(5)
redmatrix=[];greenmatrix=[]; bluematrix=[]
matrix=[]
red.each_slice(3){|x| redmatrix<<x}
green.each_slice(3){|x| greenmatrix<<x}
blue.each_slice(3){|x| bluematrix<<x}
i=0
size=redmatrix.size
for i in 0...size do
case (i%3)
	when 0 then matrix<<redmatrix[i]
	when 2 then matrix<<greenmatrix[i]
	when 1 then matrix<<bluematrix[i]
	end
end
=begin
redmatrix.each do |red_comp|
	matrix<<red_comp<<greenmatrix[i]<<bluematrix[i]
	i+=1
end
=end
p matrix.flatten.first(20)
p red.size
matrix=matrix.flatten
p matrix.size
red=matrix[0...matrix.size]
file=File.open("ImageInformation", 'wb')
file.print "RED Matrix"
file<<red
file.print "\nGREEN Matrix"
file<<green
file.print "\nBLUE Matrix"
file<<blue
buffer=red.pack("C*")
newimg=Image.new(img.columns, img.rows)
newimg.import_pixels(0,0,img.columns,img.rows,"RGB", buffer,CharPixel)
newimg.display
newimg.write"converted.jpg"
