require 'awesome_print'
require 'shellwords'

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
    # Using full path
    inputs = inputs.map do |input|
      File.expand_path(input)
    end

    # Rejecting non-existing files and files of the wrong extension
    inputs = inputs.reject do |input|
      next true unless File.exist?(input)
      next true unless File.extname(input).downcase == ".#{extension}"
      false
    end

    # Displaying error and stopping
    if inputs.empty?
      puts 'Usage:'
      puts @usage
      puts ''
      puts @documentation
      exit 1
    end

    inputs
  end

  # Convert the specified to the specified extension
  def convert(input, extension)
    dirname = File.dirname(input)
    basename = File.basename(input, File.extname(input))
    output = File.join(dirname, "#{basename}.#{extension}")
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

end
