begin_time= Time.now
require 'chunky_png'
require 'fileutils'

# How many columns of "pixels"?
width = 3

# How many rows of "pixels"?
height = 3

# How many pixels should each "pixel" actually be?
scale = 40

# Image file output directory
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
  
  png = ChunkyPNG::Image.new(width * scale, height * scale, ChunkyPNG::Color::WHITE)

  (0..height-1).each do |row|
    (0..width-1).each do |column|
      index = (row * width) + column

      # Image starts out with a white background, so only set the pixels that
      # should be black
      if binary[index] == '1'
        # png[column, row] = ChunkyPNG::Color::BLACK
        x = column * scale
        y = row * scale
        png.rect(x, y, x + scale, y + scale, ChunkyPNG::Color::BLACK, ChunkyPNG::Color::BLACK)
      end
    end
  end
  png.save('output/' + i.to_s + '.png')
end

puts 'Run time: ' + (Time.now - begin_time).to_s + ' seconds'
