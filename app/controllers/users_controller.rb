# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :admin_user, only: :destroy
  before_action :correct_user, only: %i[edit update]
  def show
    @user = User.find(params[:id])
    @microposts = Micropost.where(user_id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      flash[:success] = '登録成功'
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = '更新完了'
      redirect_to @user
    else
      render :edit
    end
  end

  def index
    @q = User.ransack(params[:q])
    @users = @q.result.order(created_at: :desc)
               .page(params[:page]).per(10)
  end
  def likes
    @user = User.find(params[:id])
    @microposts = @user.likeposts
    render :show
  end
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'ユーザーは削除されました'
    redirect_to users_url
  end

  def following
    @user = User.find(params[:id])
    @users = @user.following
    render :show_follow
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render :show_follow
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :picture,
                                 :unique_name, :address1, :address2, :zipcode, :introduce)
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(current_user) unless @user == current_user
  end
end
