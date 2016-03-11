class PostsController < ApplicationController
  # Set current post for show, edit, update, and delete methods
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :owned_post, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  # Display all posts on the index page
  def index
    @posts = Post.all
  end

  # Display current post
  def show
  end

  # CRUD methods for posts
  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = "Your post has been created!"
      redirect_to posts_path
    else
      flash.now[:alert] = "Your new post couldn't be created! Please check the form again."
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post updated."
      redirect_to (post_path(@post))
    else
      flash.now[:alert] = "Update failed. Please check the form."
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = "Your post has successfully been deleted"
    else
      flash[:alert] = "Something went wrong. Please try again."
    end
    redirect_to posts_path
  end

  #End CRUD methods

  private
  # Whitelist image and caption parameters for posts
  def post_params
    params.require(:post).permit(:image, :caption)
  end

  # Helper method to assign the current post to an ivar
  def set_post
    @post = Post.find(params[:id])
  end

  # Helper method to ensure a user cannot edit a post that's not their own
  # This method ensures that navigating to /posts/#idnumber/edit with an account
  # that is not the owner of the post will not be able to edit that post.
  def owned_post
    unless current_user == @post.user
      flash[:alert] = "That post doesn't belong to you!"
      redirect_to root_path
    end
  end
end
