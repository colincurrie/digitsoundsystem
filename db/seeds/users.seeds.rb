def create_admin(name, surname, email)
  user = User.find_or_create_by name: name, surname: surname, email: email
  user.update(password: 'password', admin: true, mailing_list: true)
  if user.errors.count == 0
    puts "Added #{name} (#{email})"
  else
    puts "Failed to add #{name} (#{email}):"
    user.errors.each { |k, v| puts "  #{k} #{v}" }
  end
end

create_admin 'Colin', 'Currie', 'colin@digitsoundsystem.co.uk'
create_admin 'Dan', 'Carrier', 'dan@digitsoundsystem.co.uk'
create_admin 'Matt', 'Gross', 'matt@digitsoundsystem.co.uk'
create_admin 'Carolyn', 'Boyle', 'carolyn@digitsoundsystem.co.uk'
