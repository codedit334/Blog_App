class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
    # @posts = Post.includes(:author)
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    # @comments = @post.comments
    @comments = Comment.includes(:post)
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to user_posts_path(current_user)

    else
      flash[:alert] = 'Something went wrong'
      render 'new'
    end
  end

  def new
    @post = Post.new
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
