class ApplicationController < ActionController::Base

  def forem_user
    current_user
  end
  helper_method :forem_user




  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :check_session

  def check_session
    if current_user.present? && current_user.status==false
        redirect_to "/users/logout", notice: "thiyagu"
    elsif !current_user.present?
      redirect_to "/users/login", alert: "Access denied..."
    end
  end



  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :address, :city, :state, :zip, :role_id, :email,:password, :password_confirmation,:avatar, :cover_photo) }
  end


end
