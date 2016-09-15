require 'awesome_print'
require 'shellwords'

# Allow access to current git repository state
module ImageHelper

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

end
