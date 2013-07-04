require 'spec_helper'
require 'pry'
describe Api::RegistrationsController, :type => :api do

  describe "#create" do

    describe "with correct payload" do
      before do
        request_payload = {
          registration: {
          name: 'John Swartz',
          password: 'pass123456',
          password_confirmation: 'pass123456',
          email: 'John@gmail.com'}
        }
        post 'api/users', request_payload
        response = last_response
        @body = JSON.parse(last_response.body)
      end

      it {last_response.status.should == 201}
      it "has the correct details" do
        @body["name"].should == 'John Swartz'
        @body["email"].should == 'john@gmail.com'
        @body["id"].should == 1
      end

    end
  end

end
