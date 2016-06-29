after :users do
  lorem = [
    'Lorem ipsum dolor sit amet, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim ',
    'Magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo ' +
        'consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ' +
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore',
    'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo cillum dolore ' +
        'consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ' +
        'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. ' +
        'consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ' +
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore'
  ]
  verbs = %w{Phat Massive Rocking Funky Amazing Aaaamaaazing Wikid Retro Boaring Huge Weird}
  genres = %w{acid-house jungle garage house illegal ragga reggae electro dance hip-hop}
  events = %w{party festival rave gig wedding bar-mitzvah party rave event party rave festival doo thing}
  venues = ['Albert Hall', 'Parliament Hill', 'Alma St', 'Trafalgar Sq', 'Water Rats']
  users = User.all.to_a
  num_events = 15
  num_events.times do |i|
    title = "#{verbs.sample} #{genres.sample} #{events.sample}"
    start_at = Chronic.parse('next Friday 8pm') + ([1,1,2].sample*i.weeks) + [0,0,0,1,1,1,2,2,3,4].sample.days
    Event.create title: title, description: lorem.sample, user: users.sample,
                 venue: venues.sample, start_at: start_at, end_at: start_at + 5.hours
  end
  puts "Added #{num_events} Events"
end
