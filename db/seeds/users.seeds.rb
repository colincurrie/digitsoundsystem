class << self
  def create_user(name, surname, email)
    lorem = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et ' +
        'dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ' +
        'ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu ' +
        'fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt ' +
        'mollit anim id est laborum.'

    user = User.find_or_create_by name: name, surname: surname, email: email, bio: lorem
    user.update(password: 'password', admin: true, mailing_list: true)
  end
end

create_user 'Colin', 'Currie', 'colin@digitsoundsystem.co.uk'
create_user 'Dan', 'Carrier', 'dan@digitsoundsystem.co.uk'
create_user 'Matt', 'Gross', 'matt@digitsoundsystem.co.uk'
create_user 'Carolyn', 'Boyle', 'carolyn@digitsoundsystem.co.uk'
puts 'Added 4 Users'

