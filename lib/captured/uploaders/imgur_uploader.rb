require 'imgur'

class ImgurUploader
  attr_accessor :url
  API_KEY = "f4fa5e1e9974405c62117a8a84fbde46"

  def upload(file)
    puts "Uploading #{file}"
    @url = Imgur::API.new(API_KEY).upload_file(file)["original_image"]
  end
end