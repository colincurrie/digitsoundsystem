after :users do
  lorem = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et ' +
      'dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea ' +
      'commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat ' +
      'nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit ' +
      'anim id est laborum.'
  urls = JSON.parse(RestClient.get('http://api.mixcloud.com/DigitSoundSystem/cloudcasts'))['data'].map { |c| c['url'] }
  users = User.all.to_a
  urls.reverse.each_with_index do |url,i|
    target = Mixtape.new(user: users.sample, url: url, description: lorem)
    created = Time.now - ((urls.count-i)*60*60*24*20) # one mixtape every 20 days
    target.created_at = target.updated_at = created
    target.save
  end
  puts "Added #{urls.count} mixtapes"
end

