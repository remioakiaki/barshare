# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.page(params[:page]).per(10)
    else
      @user = User.new
      @feed_items = Micropost.all.page(params[:page]).per(10)
    end
  end
end
