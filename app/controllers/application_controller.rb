class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :only_user_and_admin, :only_admin

  def put_user_data
    @datas = [:address, :phone, :bio]
    @filled_data_count = @datas.count
  end

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
        devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password])
        devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :current_password, :name, :phone, :address, :bio, :photo, :subscribed])
      end
end
