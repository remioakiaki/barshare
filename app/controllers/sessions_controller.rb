# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:success] = 'ログイン成功'
      redirect_to root_path
    else
      flash.now[:danger] = 'emailまたはパスワードに誤りがあります'
      render 'sessions/new'
    end
  end

  def destroy
    logout if logged_in?
    flash[:success] = 'ログアウトしました'
    redirect_to root_path
  end
end
