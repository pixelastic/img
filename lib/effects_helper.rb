# Image color effect transformation methods
module EffectsHelper
  # Return the number of colors of an image
  def palette_size(input)
    `identify -format %k #{input.shellescape}`.to_i
  end
end
