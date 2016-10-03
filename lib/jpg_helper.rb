# JPG-related methods
module JpgHelper
  # Check if file is a jpg
  def jpg?(input)
    extname = File.extname(input)
    ['.jpg', '.jpeg'].include?(extname.downcase)
  end
end
