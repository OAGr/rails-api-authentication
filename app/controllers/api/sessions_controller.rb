module Api
  class SessionsController < Devise::SessionsController
    prepend_before_filter :require_no_authentication, :only => [:create ]
    #before_filter :ensure_params_exist
    respond_to :json

    def create
      build_resource
      resource = User.find_for_database_authentication( email: params[:email] )
      return invalid_login_attempt unless resource

      if resource.valid_password?(params[:password])
        sign_in("user", resource)
        render :json => {:success=>true, :auth_token=>resource.authentication_token, :id=>resource.id, :email=>resource.email}, :status => :created
        return
      end
      invalid_login_attempt
    end

    def destroy
      resource = User.find_for_database_authentication( email: params[:email] )
      if sign_out(resource)
      render :json => {:message=>"Session deleted."}, :success => true, :status => :ok
      else 
        render :json => {:message => "User was not signed in"}, :success => false, :status => 401
      end
    end

    protected
    def ensure_params_exist
      return unless (params[:email].blank? or params[:password].blank?)
      render :json=>{:success=>false, :message=>"missing email or password parameter"}, :status=>422
    end

    def invalid_login_attempt
      warden.custom_failure!
      render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
    end
  end
end
