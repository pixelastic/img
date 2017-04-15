# Color related methods
module ColorHelper
  # Convert a rgb value into an hexadecimal one
  def rgb2hex(input)
    regex = /.*\((.*)\)/
    rgb = regex.match(input)[1]
    rgb = rgb.delete(' ').split(',')[0..2]
    hex = rgb.map { |x| format('%02x', x) }.join.upcase

    "##{hex}"
  end
end
