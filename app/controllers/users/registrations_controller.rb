# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [:update]

  def show
    redirect_to new_user_session_path, alert: "You must be logged in" unless @user = current_user
  end

  protected

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone])
  end

  def after_update_path_for(resource)
    profile_path
  end
end
