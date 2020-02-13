class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.created_at_desc
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new post_params

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
      flash[:danger] = 'Created faild.'
    end
  end

  def update
    # byebug
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
      flash[:danger] = "Update faild."
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:user_id, :title, :content, :user_id)
    end
end
