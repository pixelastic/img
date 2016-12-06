# PNG-related methods
module PngHelper
  # Check if file is a png
  def png?(input)
    File.extname(input).casecmp('.png').zero?
  end

  # Trim the image, removing whitespace around it
  def trim(input)
    options = [
      input.shellescape,
      '-trim',
      input.shellescape
    ]
    command = "convert #{options.join(' ')}"
    `#{command}`
  end
end
