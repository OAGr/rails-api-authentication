require 'spec_helper'
require 'pry'
describe Api::RoomsController, :type => :api do

  describe "#index" do

    before do
      @room1 = FactoryGirl.create(:room, name:"room1")
      @room2 = FactoryGirl.create(:room, name:"room2")
      get '/rooms', :format => :json
    end

    it {last_response.status.should == 200}

    it "should retrieve list of rooms" do
      rooms = Room.all
      rooms.count.should == 2

      last_response.body.should include(@room1.id.to_s)
      last_response.body.should include(@room2.id.to_s)
      last_response.body.should include('room1')
      last_response.body.should include('room2')
    end
  end

  describe "#show" do

    describe 'with room' do
      before do
        @room = FactoryGirl.create(:room, name:"awesome room")
        get 'api/rooms/1', :format => :json
      end

      it { last_response.status.should == 200 }

      it "should retrieve the correct player" do
        room = Room.first
        response_room = JSON.parse(last_response.body)

        response_room["id"].should == 1
        response_room["name"].should == "awesome room"
      end

    end


    describe "without room" do
      it "gives correct errors" do
        get 'api/rooms/4'
        last_response.status.should == 404

        response_message = JSON.parse(last_response.body)
        response_message['response_type'].should == "ERROR"
        response_message['response_code'].should == 404
        response_message['message'].should == "Room 4 does not exist."
      end
    end
  end

  describe "#create" do
    describe "with registered user" do
      before do
        @user1 = FactoryGirl.create(:user, email:"user1@gmail.com")
        request_payload ={
          user_id: @user1.id,
          authentication_token: @user1.authentication_token,
          room: { name: "newly created room" }
        }
        post 'api/rooms', request_payload
      end

      it {last_response.status.should == 201}

      it "properly creates room" do
        response_message = JSON.parse(last_response.body)
        response_message["id"].should == 1
        response_message["name"].should == "newly created room"
      end

      it "fails to recreate room with same name" do
        request_payload ={
          user_id: @user1.id,
          authentication_token: @user1.authentication_token,
          room: { name: "newly created room" }
        }
        post 'api/rooms', request_payload
        last_response.status.should == 422
        response_message = JSON.parse(last_response.body)
        response_message["errors"].should == {"name"=>["has already been taken"]}
      end
    end
  end

  describe "#update" do
    describe "with registered user" do
      before do
        @user1 = FactoryGirl.create(:user, email:"user1@gmail.com")
        @room1 = FactoryGirl.create(:room, name:"room1", user_id:1)
        request_payload ={
          user_id: @user1.id,
          authentication_token: @user1.authentication_token,
          room: { name: "updated room" }
        }
        put 'api/rooms/1', request_payload
      end

      it {last_response.status.should == 204}
    end
  end

  describe "#destroy" do
    describe "with registered user" do
      before do
        @user1 = FactoryGirl.create(:user, email:"user1@gmail.com")
        @room1 = FactoryGirl.create(:room, name:"room1", user_id:1)
        request_payload ={
          user_id: @user1.id,
          authentication_token: @user1.authentication_token
        }
        delete 'api/rooms/1', request_payload
      end
      it {last_response.status.should == 204}
    end
  end
end

