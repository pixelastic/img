require 'fileutils'
require 'awesome_print'
require 'filesize'
require 'shellwords'
require_relative './arguments_helper'
require_relative './dimensions_helper'
require_relative './filesize_helper'
require_relative './gif_helper'
require_relative './jpg_helper'
require_relative './output_helper'
require_relative './png_helper'
require_relative './quality_helper'
require_relative './screenshot_helper'

# Allow access to current git repository state
module ImageHelper
  include ArgumentsHelper
  include DimensionsHelper
  include FilesizeHelper
  include GifHelper
  include JpgHelper
  include OutputHelper
  include PngHelper
  include QualityHelper
  include ScreenshotHelper

  def change_extension(input, extension)
    dirname = File.dirname(input)
    basename = File.basename(input, File.extname(input))
    File.join(dirname, "#{basename}.#{extension}")
  end

  # Convert the specified to the specified extension
  def convert(input, extension)
    output = change_extension(input, extension)
    `convert #{input.shellescape} #{output.shellescape}`
    output
  end

  # Resize the specified input
  def resize(input, dimensions)
    if gif?(input)
      dimensions = dimensions.delete('!')
      return resize_gif(input, dimensions)
    end

    options = [
      "-resize #{dimensions}"
    ]
    output = input
    `convert #{input.shellescape} #{options.join(' ')} #{output.shellescape}`
  end
end
