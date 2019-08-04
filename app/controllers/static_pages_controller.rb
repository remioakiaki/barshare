class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      #@feed_items = current_user.feed.paginate(page: params[:page], per_page: 10)
    else
      @user = User.new
      #@feed_items = Micropost.all.paginate(page: params[:page], per_page: 10).includes(:user)
    end
  end
end
