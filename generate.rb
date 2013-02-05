require 'chunky_png'
require 'fileutils'

width = 3
height = 3
dir = 'output'


#########
# Make sure we've got an empty output directory
FileUtils.rm_rf(dir)
FileUtils.mkdir(dir)

bits = width * height
range = 2**(width * height)

(0..range - 1).each do |i|
  binary = i.to_s(2)
  binary = '0' * (bits - binary.length) + binary
  
  png = ChunkyPNG::Image.new(width, height)

  (0..height-1).each do |row|
    (0..width-1).each do |column|
      index = (row * width) + column

      if binary[index] == '0'
        png[column, row] = ChunkyPNG::Color('white')
      else
        png[column, row] = ChunkyPNG::Color('black')
      end
    end
  end
  png.save('output/' + i.to_s + '.png')
end
