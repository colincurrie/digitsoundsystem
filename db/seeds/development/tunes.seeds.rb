after :users do
  num_tunes = 25
  client = Soundcloud.new client_id: '70bdb497739d010e71e6f97e12adac20'
  urls = client.get('/tracks', limit: num_tunes, order: 'hotness').map(&:uri)
  users = User.all.to_a

  urls.each_with_index do |url,i|
    date = Time.now - (num_tunes-i)*60*60*24*5 # a new tune every 5 days
    Tune.create(url: url, user: users.sample, created_at: date, updated_at: date) rescue nil
  end
  puts "Added #{Tune.count} Tunes"
end
