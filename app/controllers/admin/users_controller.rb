class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :check_admin_user

  def check_admin_user
    unless current_user.role.name=="admin"
      redirect_to vehicles_path, :alert => "Access denied"
    end
  end

  def index
    @users = User.all
  end
  def show
    @user = User.find(params[:id])
    state = params[:status]=="true" ? false : true
    @user.update_attributes(:status=> state )
    redirect_to admin_users_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.find(params[:user])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    if @user.save
      redirect_to users_path
    else
      render "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.delete
    redirect_to users_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, assets_attributes: [:avatar, :cover_photo])
    end

end
