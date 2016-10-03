# Dimensions related methods
module DimensionsHelper
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
