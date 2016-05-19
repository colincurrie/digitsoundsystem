# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

LOREM = [
    'Lorem ipsum dolor sit amet',
    'magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo ',
    'magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo ' +
        'consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ' +
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore',
    'magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo ' +
        'consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ' +
        'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. '
]
MAX_COMMENTS = 10
MAX_STORIES = 100
NUM_STORIES = 25

def create_admins
  create_admin 'Colin', 'Currie', 'colin@digitsoundsystem.co.uk'
  create_admin 'Dan', 'Carrier', 'dan@digitsoundsystem.co.uk'
  create_admin 'Matt', 'Gross', 'matt@digitsoundsystem.co.uk'
  create_admin 'Carolyn', 'Boyle', 'carolyn@digitsoundsystem.co.uk'
end

def create_admin name, surname, email
  user = User.create(name: name, surname: surname, email: email, password: 'password', admin: true, mailing_list: true)
  if user.errors.count == 0
    puts "Added #{name} (#{email})"
  else
    puts "Failed to add #{name} (#{email}):"
    user.errors.each { |k,v| puts "  #{k} #{v}" }
  end
end

def create_stories
  @users = User.all
  num_stories = NUM_STORIES
  num_stories.times do |i|
    create_story i, num_stories, @users[i%@users.count]
  end
  puts "Added #{Story.count} Stories"
end

def create_story(index, total, user)
  story = Story.create(title: "Story #{index+1} of #{total}: #{LOREM.first}", content: LOREM.last(3).shuffle.first, user: user)
  story_date = Time.now - (total*8*60*60) + rand(index*8*60*60)
  story.created_at = story_date
  story.updated_at = story_date
  if story.save
    num_comments = rand(MAX_COMMENTS)
    num_comments.times do |i|
      create_comment i, @users[i%@users.count], story
    end
    puts "Created #{story.comments.count} comments for #{story}"
  end
end

def create_comment(index, user, story)
  comment = Comment.create(user: user, story: story, content: LOREM[index%LOREM.length])
  comment.created_at = story.created_at + (index*66*60)
  comment.updated_at = comment.created_at
  comment.save
end

create_admins
create_stories
