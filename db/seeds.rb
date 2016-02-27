# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def create_admin name, surname, email
  user = User.create(name: name, surname: surname, email: email, password: 'password', admin: true, mailing_list: true)
  if user.errors.count == 0
    puts "Added #{name} (#{email})"
  else
    puts "Failed to add #{name} (#{email}):"
    user.errors.each { |k,v| puts "  #{k} #{v}" }
  end
end

create_admin 'Colin', 'Currie', 'colin@digitsoundsystem.co.uk'
create_admin 'Dan', 'Carrier', 'dan@digitsoundsystem.co.uk'
create_admin 'Matt', 'Gross', 'matt@digitsoundsystem.co.uk'
create_admin 'Carolyn', 'Boyle', 'carolyn@digitsoundsystem.co.uk'
