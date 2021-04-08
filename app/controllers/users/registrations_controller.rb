class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_authentication, only: :show
  before_action :configure_account_update_params, only: :update

  def show
    @user = current_user
  end

  protected

  def check_authentication
    redirect_to new_user_session_path, alert: "You must be logged in" unless current_user
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone])
  end

  def after_update_path_for(resource)
    profile_path
  end
end
