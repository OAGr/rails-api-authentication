module Api
  class RoomsController < ApplicationController
    before_filter :authenticate_token!, :only => [:create, :update, :destroy]
    before_filter :authorize_user!, :only => [:update, :destroy]

    respond_to :json

    def index
      respond_with Room.all
    end

    def show
      begin
        @room = Room.find(params[:id])
        respond_with Room.find(params[:id])
      rescue
        error(404, 404, "Room #{params[:id]} does not exist.")
      end
    end

    def create
      respond_with Room.create(params[:room])
    end

    def update
      respond_with Room.update(params[:id], params[:room])
    end

    def destroy
      respond_with Room.destroy(params[:id])
    end

    private

    def authenticate_token!
      if User.find_by_id(params[:user_id]).nil?
        render :json => {:message => "User does not exist."}, :success => false, :status => 422
      elsif User.find_by_id(params[:user_id]).authentication_token == params[:authentication_token]
        #params[:room][:user_id] = params[:user_id]
        true
      else
        render :json => {:message => "Missing correct authentication token."}, :success => false, :status => 401
      end
    end

    def authorize_user!
      if Room.find(params[:id]).user_id == params[:user_id].to_i
        true
      else
        render :json => {:message => "User not authorized to change this content"}, :success => false, :status => 401
      end
    end

  end
end
