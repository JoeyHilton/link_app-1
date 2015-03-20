class CommentsController < ApplicationController
before_action :authenticate_user!
before_action :set_post

  def new
    @comment = @post.comments.build
  end

  def edit
    @comment = Comment.find(params[:id])
    if @comment.user != current_user
      redirect_to @post, notice: "Sorry Charlie!"
    end
  end

  def create
    @comment = @post.comments.build(comment_params)
    if @comment.save
      redirect_to @post
    else
      render :new
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      redirect_to @post
    else
      redirect_to @post, notice: "Sorry Charlie!"
  end
end


private

  def set_post
    @post = Post.find(params[:post_id])
  end


  def comment_params
    params.require(:comment).permit(:body, :user_id, :post_id)
  end
end