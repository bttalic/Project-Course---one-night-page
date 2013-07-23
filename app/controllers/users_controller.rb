class UsersController < ApplicationController
  before_filter :signed_in_user, 
                only: [:index, :edit, :update, :destroy, :listening, :listeners]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @courses_taking=@user.listened_courses
    @courses_teaching=Course.where(:user_id=>@user.id)
  #  @notifications = @user.notifications.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the CS @ IUS!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def updateoffice
    @user=User.find(params[:id])
    @user.officehours=params[:offisehours]
    if @user.save!
    flash[:success] = "Office hours updated"
    redirect_to @user
  else
    flash[:error] = "Office hours not updated"
    redirect_to @user
  end
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def listening
    @title = "Taking"
    @user = User.find(params[:id])
    @courses = @user.listened_courses.paginate(page: params[:page])
    render 'show_listen'
  end



  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end