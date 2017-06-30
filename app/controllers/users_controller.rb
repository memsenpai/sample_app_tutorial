class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create, :show]
  before_action :find_user, except: [:index, :create, :new]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate page: params[:page],
      per_page: Settings.paginate.per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t ".activate"
      redirect_to root_url
    else
      render :new
    end
  end

  def show
    @microposts = @user.microposts.paginate page: params[:page],
      per_page: Settings.paginate.per_page
    @unfollow = current_user.active_relationships.find_by followed_id: @user.id
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t ".updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t ".destroy", user: @user.name
    redirect_to users_url
  end

  def following
    @title = t "following"
    @user = User.find_by id: params[:id]
    @users = @user.following.paginate page: params[:page]
    render :show_follow
  end

  def followers
    @title = t "followers"
    @user = User.find_by id: params[:id]
    @users = @user.followers.paginate page: params[:page]
    render :show_follow
  end

  private

  def find_user
    @user = User.find_by id: params[:id]

    return if @user
    redirect_to root_url
    flash[:info] = t ".notfound"
  end

  def user_params
    params.require(:user).permit :name, :email,
      :password, :password_confirmation, :activation_digest
  end

  def correct_user
    redirect_to root_url unless @user.current_user? current_user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
