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

  def maincolor(image)
    options = [
      image.shellescape,
      '-scale 1x1!',
      "-format '%[pixel:u]'",
      'info:-'
    ]
    command = "convert #{options.join(' ')}"
    raw = `#{command}`

    rgb2hex(raw)

  end


end
