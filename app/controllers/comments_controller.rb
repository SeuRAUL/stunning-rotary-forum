class CommentsController < ApplicationController
  before_action :message, only: [:create, :edit, :update, :destroy]
  before_action :comment, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]

  def create
    @comment = @message.comments.create(comment_params)
    @comment.user_id = current_user.id

    if @comment.save 
      redirect_to @message 
    else
      render 'new'
    end
  end

  def edit 
  end

  def update
    if @comment.update(comment_params)
      redirect_to @message
    else
      render 'edit'
    end
  end

  def destroy
    @comment.destroy
    redirect_to @message
  end

  private

    def comment 
      @comment = Comment.find(params[:id])
    end

    def message 
      @message = Message.find(params[:message_id])
    end

    def comment_params 
      params.require(:comment).permit(:content)
    end
end
