def process_image(filename, file)

  open_image(filename, file)

  image_name = generate_filename

  convert_image(filename, image_name)

  delete_original_image(filename)

  return "/imgs/uploads/#{image_name}.png"

end


def open_image(filename, file)
  File.open(File.join(APP_ROOT, '/public/imgs/uploads', filename), "w") do |f|
    f.write(file)
  end
end

def generate_filename(url_chars =[])
  ("A".."Z").to_a.push(*("a".."z").to_a.push(*('0'..'9').to_a)).shuffle.first(20).join
end

def convert_image(filename, image_name)
  image = MiniMagick::Image.open("#{APP_ROOT}/public/imgs/uploads/#{filename}")
  image.resize "200x200"
  image.format "png"
  image.write "#{APP_ROOT}/public/imgs/uploads/#{image_name}.png"
end

def delete_original_image(filename)
  File.delete("#{APP_ROOT}/public/imgs/uploads/#{filename}")
end