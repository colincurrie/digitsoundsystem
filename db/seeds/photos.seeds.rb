after :users do
  images = Dir[ENV.fetch('SRC_PHOTOS','')].shuffle
  if images.empty?
    puts 'Specify SRC_PHOTOS to specify source images to seed Photos'
  else
    num_photos = 5
    puts "Creating #{num_photos} photos ..."
    users = User.all.to_a
    num_photos.times do |i|
      photo = Photo.new(description: "Photo #{i+1} of #{num_photos}", user: users.sample, image: File.new(images.pop))
      created = Time.now - ((num_photos+i)*8*60*60) # one photo every 8 hours
      photo.created_at = photo.updated_at = created
      photo.save
    end
    puts 'done'
  end
end