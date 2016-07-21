class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  after_filter :store_location

  DEFAULT_PER_PAGE = 10

  def store_location
    # store last url as long as it isn't a /users path
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  protected

  def user_params
    params.merge user: current_user
  end

  def page
    params.fetch('page', 1)
  end

  def per_page
    params.fetch('per_page', DEFAULT_PER_PAGE)
  end
end
