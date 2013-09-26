class AuthenticationsController < ApplicationController
  before_action :set_authentication, only: [:show, :edit, :update, :destroy]
  skip_before_filter :check_session, :only => [:facebook]


  def facebook
    omni = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omni['provider'], omni['uid'])

    if authentication # already have auth before.
      flash[:notice] = "Logged in Successfully"
      sign_in_and_redirect User.find(authentication.user_id)
    elsif current_user # current logging user but still don't have auth before.
        token = omni['credentials'].token
        token_secret = ""

        current_user.authentications.create!(:provider => omni['provider'], :uid => omni['uid'], :token => token, :token_secret => token_secret)

        flash[:notice] = "Authentication successful."
        sign_in_and_redirect current_user

      else
        user = User.find_by_email(omni['extra']['raw_info'].email)
      if user.nil?
        user = User.new
        user.name = omni['extra']['raw_info'].name
        user.email = omni['extra']['raw_info'].email

        user.apply_omniauth(omni)

        if user.save
          flash[:notice] = "Logged in."
          sign_in_and_redirect User.find(user.id)
        else
          session[:omniauth] = omni.except('extra')
          redirect_to  :controller => 'users/registrations', :action => 'new', :params =>omni['info']
          #redirect_to new_user_registration_path
        end
      else # old user but not logging now
        token = omni['credentials'].token
        token_secret = ""

        user.authentications.create!(:provider => omni['provider'], :uid => omni['uid'], :token => token, :token_secret => token_secret)

        flash[:notice] = "Authentication successful."
        sign_in_and_redirect user
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_authentication
      @authentication = Authentication.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def authentication_params
      params.require(:authentication).permit(:user_id, :provider, :uid)
    end
end
