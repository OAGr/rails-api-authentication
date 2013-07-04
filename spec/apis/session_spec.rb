require 'spec_helper'
require 'pry'
describe Api::SessionsController, :type => :api do

  describe '#create' do
    before do
      request_payload = {
        registration: {
          name: 'John Swartz',
          password: 'pass123456',
          password_confirmation: 'pass123456',
          email: 'John@gmail.com'}
      }
      post 'api/users', request_payload
      @registration_response = last_response
      @registration = JSON.parse(last_response.body)
      @user = User.first
    end

    describe 'with correct user' do
      it "login with correct credentials" do
        request_payload = {
          password: 'pass123456',
          email: 'John@gmail.com'
        }
        post 'api/users/sign_in', request_payload
        body = JSON.parse(last_response.body)
        last_response.status.should == 201
        body["auth_token"].should == @user.authentication_token
        body["id"].should == @user.id
        body["email"].should == @user.email
      end
    end

    describe 'with incorrect user' do
      it "gives error with wrong credentials" do
        request_payload = {
          password: 'wrongpassword',
          email: 'John@gmail.com'
        }
        post 'api/users/sign_in', request_payload
        body = JSON.parse(last_response.body)
        last_response.status.should == 401
        body["success"].should == false
        body["message"].should == "Error with your login or password"
      end
    end

  end 
end
