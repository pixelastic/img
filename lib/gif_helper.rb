# GIF-related methods
module GifHelper
  # Check if file is a gif
  def gif?(input)
    File.extname(input).casecmp('.gif').zero?
  end

  # Specific method to resize GIF
  def resize_gif(input, dimensions)
    gifsicle_options = [
      '--batch',
      "--resize #{dimensions}",
      '--colors 256',
      input.shellescape
    ]

    command = "gifsicle #{gifsicle_options.join(' ')} 2>/dev/null"

    `#{command}`
  end

  # Returns true if input is an animated GIF
  def animated_gif?(input)
    return false unless gif?(input)
    frames = `identify -format %n #{input.shellescape}`.to_i
    frames > 1
  end

  # Returns true if gif is animated with an infinite loop
  def looped_gif?(input)
    return false unless gif?(input)
    raw = `exiftool #{input.shellescape} | grep 'Animation Iterations'`.strip
    raw.split(' : ')[1] == 'Infinite'
  end
end
