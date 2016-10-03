# Filesize-related methods
module FilesizeHelper
  # Return a filesize in B
  def filesize(path)
    File.size(path).to_f
  end

  # Return a human readable filesize
  def readable_filesize(filesize)
    Filesize.from("#{filesize} B").pretty.delete(' ')
  end

  # Display the amount of filesize saved
  def display_compress(input, from, to)
    percent = (1 - (from / to)).round(2) * 100
    readable_from = readable_filesize(from)
    readable_to = readable_filesize(to)

    basename = File.basename(input)

    puts "✔ #{basename} #{readable_from} => #{readable_to} (#{percent}%)"
  end

end
