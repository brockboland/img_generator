width = 4
height = 4

bits = width * height
range = 2**(width * height)

(0..range - 1).each do |i|
  binary = i.to_s(2)
  binary = '0' * (bits - binary.length) + binary
  disp = binary.gsub('1', 'X').gsub('0', ' ')
  
  (0..height-1).each do |row|
    start = row * width
    finish = start + width - 1
    puts disp[start..finish]
  end
  
  puts "\n\n"
end
