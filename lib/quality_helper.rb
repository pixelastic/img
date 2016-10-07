require 'tempfile'
require 'shellwords'

# Quality related methods
module QualityHelper
  def initialize
    @dssim_lower_bound = 0.014250
    @dssim_upper_bound = 0.016500
  end

  # Convert a file to a temporary png
  def temp_png(input)
    return false if png?(input)

    # Create the temp directory
    tmp_dir = File.join(Dir.tmpdir, 'img', 'run')
    FileUtils.mkdir_p(tmp_dir)

    # Copy the input to a temp location
    initial_ext = File.extname(input)
    tmp_copy = Tempfile.new('temp_png')
    tmp_copy_path = "#{tmp_copy.path}#{initial_ext}"
    FileUtils.cp(input, tmp_copy_path)

    # Convert that copy to a png and return the path
    png_path = convert(tmp_copy_path, 'png')
    tmp_copy.unlink
    png_path
  end

  # Return a DSSIM score between two files
  def dssim(original, compressed)
    # Only works on png files
    original = temp_png(original) unless png?(original)
    compressed = temp_png(compressed) unless png?(compressed)

    difference = `dssim #{original.shellescape} #{compressed.shellescape}`

    value = difference.strip.split("\t")[0].to_f
    value
  end

  # Compress a file
  def compress(input, quality = 80)
    return compress_jpg(input, quality) if jpg?(input)
  end

end
