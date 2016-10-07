# JPG-related methods
module JpgHelper
  # Check if file is a jpg
  def jpg?(input)
    extname = File.extname(input)
    ['.jpg', '.jpeg'].include?(extname.downcase)
  end

  # Compress a JPG file
  def compress_jpg(input, quality = 80)
    options = [
      '-q -p -f',
      "--max=#{quality}",
      '--strip-all',
      '--all-progressive',
      input.shellescape
    ]
    command = "jpegoptim #{options.join(' ')}"
    `#{command}`
  end
end
