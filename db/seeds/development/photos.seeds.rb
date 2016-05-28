after :users do
  puts 'Specify SRC_PHOTOS to specify source images to seed Photos' unless ENV['SRC_PHOTOS']
  images = Dir[ENV.fetch('SRC_PHOTOS','')].shuffle
  unless images.empty?
    num_photos = 50
    users = User.all.to_a
    num_photos.times do |i|
      photo = Photo.new(description: "Photo #{i+1} of #{num_photos}", user: users.sample, image: File.new(images.pop))
      created = Time.now - ((num_photos+i)*8*60*60) # one photo every 8 hours
      photo.created_at = photo.updated_at = created
      photo.save
    end
    puts "Added #{num_photos} Photos"
  end
end