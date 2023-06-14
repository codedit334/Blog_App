class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @all_posts = params[:all_posts] ? @user.posts : false
  end
end
