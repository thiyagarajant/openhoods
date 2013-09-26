class Users::RegistrationsController < Devise::RegistrationsController
  #skip_before_filter :check_session
  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end

  def create
    super
    session[:omniauth] = nil unless @user.new_record?
  end

end
