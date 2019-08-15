class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :only_user_and_admin, :only_admin

  def only_user_and_admin(data)
    if current_user
      redirect_to root_path unless current_user.id == data.user_id || current_user.admin == true
    else
      redirect_to root_path
    end
  end

  def only_admin
    if current_user
      redirect_to root_path unless current_user.admin == true
    else
      redirect_to root_path
    end
  end

  protected

      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :subscribed) }
        devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :password, :current_password, :name, :phone, :address, :bio, :photo, :subscribed) }
      end
end
