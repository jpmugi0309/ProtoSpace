class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comments_params)
    if @comment.save
      redirect_to prototype_path(@comment.prototype)
    else
      @user = User.find(params[:id])
      @prototype = @comment.prototype
      render "users/show", status: :unprocessable_entity
    end
  end

  private

  def comments_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
