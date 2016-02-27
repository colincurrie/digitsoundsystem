class DjsController < ApplicationController
  def show
    @title = 'DJs'
    @djs = [User.find(2), # Dan
            User.find(1), # Colin
            User.find(4), # Matt
            User.find(3)] # Carolyn
  end
end
