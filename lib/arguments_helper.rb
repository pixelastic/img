# Arguments-related methods
module ArgumentsHelper
  # Check if the input is an image
  def image?(input)
    methods = [:jpg?, :gif?, :png?]
    methods.each do |method|
      return true if send(method, input)
    end
    false
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
end
