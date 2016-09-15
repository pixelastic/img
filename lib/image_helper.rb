# Allow access to current git repository state
module ImageHelper

  def validate_inputs(inputs, extension)
    inputs = inputs.map do |input|
      File.expand_path(input)
    end

    inputs = inputs.reject do |input|
      next true unless File.exist?(input)
      next true unless File.extname(input).downcase == extension
      false
    end

    if inputs.empty?
      puts 'Usage:'
      puts @usage
      puts ''
      puts @documentation
      exit 1
    end
  end

end
