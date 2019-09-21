class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  before_action :store_user_location!, if: :storable_location?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, :set_current_user
  # layout :set_layout

  def set_layout
    if current_user.present?
      cp = Company.all.joins(:company_users).where("companies.id = company_users.company_id and company_users.user_id = #{current_user.id}").first

      if cp.present? || current_user.admin == true
        'application'
      else
        'company_not_found'
      end
    else
      'application'
    end
  end

  def set_current_user
    User.current = current_user
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :user
      new_user_session_path
    else
      root_path
    end
  end

  def after_sign_in_path_for(resource)
    cp = Corporation.all.joins(:corporation_users).where("corporations.id = corporation_users.corporation_id and corporation_users.user_id = #{current_user.id}").first

    if cp.present?
      '/appointments'
    else
      '/home/not_found'
    end
  end

  def after_invite_path_for(resource)
    stored_location_for(resource) || super
  end

  def after_resetting_password_path_for(resource_or_scope)
    root_path
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def verifySignIn
    data = User.where("id = #{current_user.id} and company_id is not null").count(:id)
    return render :json => { :verificate => data }
  end


  private
    def storable_location?
      request.get? && is_navigational_format? && !devise_controller? && !request.xhr? 
    end

    def store_user_location!
      # :user is the scope we are authenticating
      store_location_for(:user, request.fullpath)
    end


  protected
    def configure_permitted_parameters
      attributes = [:username, :admin]
      devise_parameter_sanitizer.permit(:accept_invitation, keys: attributes)
      devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    end
end
