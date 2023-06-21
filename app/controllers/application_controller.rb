class ApplicationController < ActionController::Base
  # def current_user
  #   @current_user ||= User.first
  # end
  before_action :authenticate_user!
end
