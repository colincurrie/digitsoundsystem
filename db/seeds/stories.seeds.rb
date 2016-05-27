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
  users = User.all.to_a
  num_stories = 25
  num_stories.times do |i|
    story = Story.create(title: "Story #{i+1} of #{num_stories}: #{lorem.first}", content: lorem.last(3).shuffle.first, user: users.sample)
    story.created_at = story.updated_at = Time.now - ((num_stories-i)*60*60*24*7) # one story a week
    story.save
  end
  puts "Added #{num_stories} stories"
end
