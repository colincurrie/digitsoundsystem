after :users do
  lorem = [
      'Lorem ipsum dolor sit amet',
      'Consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim ',
      'Magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo ' +
          'consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ' +
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore',
      'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo cillum dolore ' +
          'consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ' +
          'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. ' +
          'consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ' +
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore'
  ]
  num_videos = 15
  users = User.all.to_a
  begin
    urls = RestClient::Request.execute(url: 'http://www.youtube.com/', :method => :get, :verify_ssl => false)
        .scan(/watch\?v=[^"]+/).map { |id| "http://www.youtube.com/#{id}" }.uniq
  rescue
    urls = num_videos.times.map { [*('a'..'z'), *('A'..'Z'), *('0'..'9')].shuffle[0, 11].join }
  end
  num_videos.times do |i|
    user = users.sample
    description = lorem.sample
    url = urls[i%urls.size] # use urls in sequence
    frequency = 60*60*24*4 # a couple of videos a week
    created = Time.now - (num_videos*frequency)+(i*frequency)
    Video.create(title: "Video #{i+1} of #{num_videos}", description: description, url: url, user: user, score: created, created_at: created)
  end
  puts "Created #{num_videos} Videos"
end

