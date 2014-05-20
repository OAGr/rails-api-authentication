class ApplicationController < ActionController::Base
  protect_from_forgery
  # before_filter: allow_cors_requests
  # def allow_cors
  # 	headers["Access-Control-Allow-Origin"] = "*"
  # 	headers["Access-Control-Allow-Methods"] = %w{GET POST PUT DELETE}.join(",")
  # 	headers["Access-Control-Allow-Headers"] = %w{Origin Accept Content-Type X-Requested-With X-CSRF-Token}.join(",")
  # 	head(:ok) if request.request_method == "OPTIONS"
  # 	# or, render text: ''
  # 	# if that's more your style
  # end

  def error(status, code, message)
    render :json => {:response_type => "ERROR", :response_code => code, :message => message}.to_json, :status => status
  end
end
