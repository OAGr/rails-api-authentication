module Api
  class RegistrationsController < ApplicationController
    respond_to :json

    skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }

    def create
      user = User.new(params[:registration])
      
      if user.save
        render :json=> user.as_json(:email=>user.email), :status=>201
        return
      else
        warden.custom_failure!
        puts user
        puts 'What is going on here?'
        puts user.as_json
        render :json=> user.errors, :status=>422
      end
    end
  end
end
