
class RegistrationsController < Devise::RegistrationsController
  def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up) << :chatwork_id
  end

  def configure_account_update_params
    devise_parameter_sanitizer.for(:account_update) << :chatwork_id
  end

  private
  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation,
      :chatwork_id)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation,
      :current_password, :chatwork_id)
  end
end