class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  DEFAULT_PER_PAGE = 10

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
