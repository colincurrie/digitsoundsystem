module TunesHelper
  def real_user(user)
    user.kind_of?(User) && current_user && (current_user.id==user.id) ? 'You' : user.name
  end
end
