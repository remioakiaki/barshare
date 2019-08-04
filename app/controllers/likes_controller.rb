class LikesController < ApplicationController
  def create
    @micropost = Micropost.find(params[:micropost_id])
    current_user.good(@micropost)
    @micropost.reload
  end

  def destroy
    @micropost = Micropost.find(params[:micropost_id])
    current_user.notgood(@micropost)
    @micropost.reload
  end

  private

  def like_params
    params.permit(:micropost_id)
  end
end
