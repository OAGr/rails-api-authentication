class ApplicationController < ActionController::Base
  protect_from_forgery

  def error(status, code, message)
    render :json => {:response_type => "ERROR", :response_code => code, :message => message}.to_json, :status => status
  end
end
