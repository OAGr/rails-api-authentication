module Api
  class RegistrationsController < ApplicationController
    respond_to :json
    skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }

    def create
      user = User.new(params[:registration])
      
      if user.save
        render :json=> user.as_json, :status=>201
        return
      else
        warden.custom_failure!
        render :json=> user.errors, :status=>422
      end
    end
  end
end
