module Api
  class RoomsController < ApplicationController
    respond_to :json

    def index
      respond_with Room.all
    end

    def show
      @room = Room.find(params[:id])
      respond_with Room.find(params[:id])
    rescue
      error(404, 404, "Room #{params[:id]} does not exist.")
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

  end
end
