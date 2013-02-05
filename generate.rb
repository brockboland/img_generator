begin_time= Time.now

# oily_png is a faster implementation of chunky_png. Both work the same; either
# may cause disastrous problems for you.
# require 'chunky_png'
require 'oily_png'
require 'fileutils'

# How many columns of blocks?
width = 3

# How many rows of blocks?
height = 3

# How many pixels should each block actually be?
scale = 40

# Image file output directory
dir = 'output'

#########
# Make sure we've got an empty output directory
FileUtils.rm_rf(dir)
FileUtils.mkdir(dir)

bits = width * height
range = 2**(width * height)

# Loop over each variation
(0..range - 1).each do |i|
  # Convert the number to binary and zero-pad
  # 0 will become white block, 1 will become black block
  binary = i.to_s(2)
  binary = '0' * (bits - binary.length) + binary

  # Create a blank white canvas
  png = ChunkyPNG::Image.new(width * scale, height * scale, ChunkyPNG::Color::WHITE)

  # Loop over each bit in the string, each of which represents a block of color
  (0..height-1).each do |row|
    (0..width-1).each do |column|
      index = (row * width) + column

      # Image starts out with a white background, so only set the pixels that
      # should be black
      if binary[index] == '1'
        # Determine the boundaries of this block of color
        startX = column * scale
        endX = startX + scale - 1
        startY = row * scale
        endY = startY + scale - 1

        # Color in the block, one pixel at a time
        (startX..endX).each do |x|
          (startY..endY).each do |y|
            png[x, y] = ChunkyPNG::Color::BLACK
          end
        end
      end
    end
  end

  # Save the resulting image
  png.save('output/' + i.to_s + '.png')
end

puts 'Run time: ' + (Time.now - begin_time).to_s + ' seconds'
