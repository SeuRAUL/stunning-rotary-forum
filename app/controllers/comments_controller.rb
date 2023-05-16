class CommentsController < ApplicationController
  before_action :message, only: [:new, :create]

  def new 
    @comment = @message.comments.build
  end

  def create
    @comment = @message.comments.create(comment_params)
    @comment.user_id = current_user.id

    if @comment.save 
      redirect_to @message 
    else
      render 'new'
    end
  end

  private

    def message 
      @message = Message.find(params[:message_id])
    end

    def comment_params 
      params.require(:comment).permit(:content)
    end
end
