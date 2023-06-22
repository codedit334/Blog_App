class Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token

  def new
    super
  end

  def create
    super
  end
end
