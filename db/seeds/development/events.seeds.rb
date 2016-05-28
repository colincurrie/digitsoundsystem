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
  venues = ['Albert Hall', 'Parliament Hill', 'Alma St', 'Trafalgar Sq', 'Water Rats']
  users = User.all.to_a
  num_events = 15
  num_events.times do |i|
    start_at = Chronic.parse('next Saturday 8pm') + (2*i.weeks)
    end_at =
    Event.create title: "Event #{i+1} of #{num_events}", description: lorem.sample, user: users.sample,
                 venue: venues.sample, start_at: start_at, end_at: start_at + 5.hours
  end
  puts "Added #{num_events} Events"
end
