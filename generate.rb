begin_time= Time.now
require 'chunky_png'
require 'fileutils'

width = 4
height = 4
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
  
  png = ChunkyPNG::Image.new(width, height, ChunkyPNG::Color::WHITE)

  (0..height-1).each do |row|
    (0..width-1).each do |column|
      index = (row * width) + column

      # Image starts out with a white background, so only set the pixels that
      # should be black
      if binary[index] == '1'
        png[column, row] = ChunkyPNG::Color::BLACK
      end
    end
  end
  png.save('output/' + i.to_s + '.png')
end

puts 'Run time: ' + (Time.now - begin_time).to_s + ' seconds'
