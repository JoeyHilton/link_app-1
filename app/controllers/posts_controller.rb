class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :vote, :downvote]
 
  def index
    @posts = Post.all.order(vote: :desc)
  end

  def show
    
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
   
    if @post.user != current_user
      redirect_to @post, notice: "Sorry Charlie, you can't edit this."
    end
  end

  def vote
    
    @post.vote += 1
    @post.save!
    redirect_to posts_path
  end

  def downvote
   
    @post.vote -= 1
    @post.save!
    redirect_to posts_path
  end


  def update
   

    if @post.update(post_params)
      redirect_to posts_path
    else
      render :edit
    end
  end

  def destroy
    if @post.user == current_user
      @post.destroy
    else
      redirect_to @post, notice: "Nope"
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end


  def post_params
    params.require(:post).permit(:title, :url, :vote, :user_id)
  end
end
