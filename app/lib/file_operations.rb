module FileOperations
  require 'json'
  require 'open-uri'

  def import_data_list(url)
    data = []
    URI.open(url) { |f| f.each_line { |l| data << JSON.parse(l) } }
    data
  rescue OpenURI::HTTPError => e
    puts "Invalid URL. Error: #{e.message}"
  rescue Exception => e
    puts "Error while processing file. Error: #{e.message}"
  end

  def export_data_list(output_file_name, data)
    File.open(output_file_name, 'wb') do |f|
      data.each do |d|
        f.puts(d.to_json)
      end
    end
  rescue Errno::ENOENT => e
    puts "Issue with the output file. Error: #{e.message}"
  rescue Exception => e
    puts "Can't save file. Error: #{e.message}"
  end
end