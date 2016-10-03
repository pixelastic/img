# PNG-related methods
module PngHelper
  # Check if file is a png
  def png?(input)
    File.extname(input).casecmp('.png').zero?
  end
end
