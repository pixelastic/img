require 'awesome_print'
require 'shellwords'
require 'filesize'

# Allow access to current git repository state
module ImageHelper
  # Check if the input is an image
  def image?(input)
    input = File.expand_path(input)
    return false unless File.exist?(input)
    allowed_extensions = %w(.gif .png .jpg)

    allowed_extensions.include?(File.extname(input))
  end

  # Check that all the input exists and are of the current type
  def validate_inputs(inputs, extension)
    extension = extension.split(',') if extension.include?(',')

    # Using full path
    inputs = inputs.map do |input|
      File.expand_path(input)
    end

    # Rejecting non-existing files and files of the wrong extension
    inputs = inputs.reject do |input|
      next true unless File.exist?(input)

      extname = File.extname(input).downcase
      if extension.is_a? Array
        next true unless extension.include?(extname[1..-1])
      else
        next true unless extname == ".#{extension}"
      end
      false
    end

    # Displaying error and stopping
    display_usage if inputs.empty?

    inputs
  end

  def display_usage
    puts 'Usage:'
    puts @usage
    puts ''
    puts @documentation
    exit 1
  end

  def change_extension(input, extension)
    dirname = File.dirname(input)
    basename = File.basename(input, File.extname(input))
    File.join(dirname, "#{basename}.#{extension}")
  end

  # Convert the specified to the specified extension
  def convert(input, extension)
    output = change_extension(input, extension)
    `convert #{input.shellescape} #{output.shellescape}`
  end

  # Returns the width of the input
  def width(input)
    raw = `exiftool -ImageWidth #{input.shellescape}`
    raw.split(':')[-1].to_i
  end

  # Returns the height of the input
  def height(input)
    raw = `exiftool -ImageHeight #{input.shellescape}`
    raw.split(':')[-1].to_i
  end

  # Check if file is a gif
  def gif?(input)
    File.extname(input).casecmp('.gif')
  end

  # Returns true if input is an animated GIF
  def animated_gif?(input)
    return false unless gif?(input)
    frames = `identify -format %n #{input.shellescape}`.to_i
    frames > 1
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

  # Resize the specified input
  def resize(input, dimensions)
    if animated_gif?(input)
      dimensions = dimensions.delete('!')
      return resize_gif(input, dimensions)
    end

    options = [
      "-resize #{dimensions}"
    ]
    output = input
    `convert #{input.shellescape} #{options.join(' ')} #{output.shellescape}`
  end

  # Return a filesize in B
  def filesize(path)
    File.size(path).to_f
  end

  # Return a human readable filesize
  def readable_filesize(filesize)
    Filesize.from("#{filesize} B").pretty.delete(' ')
  end

  # Display the amount of filesize saved
  def display_compress(input, from, to)
    percent = (1 - (from / to)).round(2) * 100
    readable_from = readable_filesize(from)
    readable_to = readable_filesize(to)

    basename = File.basename(input)

    puts "✔ #{basename} #{readable_from} => #{readable_to} (#{percent}%)"
  end

  # Compress a GIF file
  def compress_gif(input)
    before = filesize(input)
    options = [
      '--batch',
      '-O3',
      '--colors 256',
      input.shellescape
    ]

    command = "gifsicle #{options.join(' ')} 2>/dev/null"
    `#{command}`

    after = filesize(input)

    display_compress(input, before, after)
  end
end
