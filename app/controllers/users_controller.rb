class UsersController < ApplicationController
  before_action :logged_in_user, except: [:show, :new, :create]
  before_action :admin_user, only: :destroy
  before_action :load_users ,except: [:index, :new, :create]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.paginate page: params[:page], per_page: Settings.per_page
  end


  def show
  end


  def new
    @user = User.new
  end


  def edit
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".welcome"
      redirect_to @user
    else
      render :new
    end
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".success"
      redirect_to @user
    else
      flash.now[:warning] = t ".fails"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".delete"
      redirect_to users_url
    else
      flash.now[:danger] = t ".fail"
      render :index
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def load_users
    @user = User.find_by id: params[:id]
    unless @user
      flash[:warning] = t ".just_sign"
      redirect_to root_url

    end
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t ".login"
      redirect_to login_url
    end
  end

  def correct_user
    unless @user == current_user
      flash[:danger] = t ".info"
      redirect_to root_url
    end
  end

  def admin_user
    unless current_user.admin?
      flash[:danger] = t ".notadmin"
      redirect_to root_url
    end
  end
end
