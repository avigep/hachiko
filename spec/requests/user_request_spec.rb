require 'rails_helper'

RSpec.describe "Users", type: :request do
    let(:valid_attributes) { { "email"=>"test@mail.com" } }
    let(:invalid_attributes) { { "email"=>"test" } }
  
    let(:api_headers) { {'Authorization': 'Bearer some-api-key'}}

    describe "POST /users" do
      context "with invalid access token" do
        it "renders unauthorized" do
          post users_url, params: { user: valid_attributes }, headers: {}
          expect(response.status).to eq(401)
          expect(response.message).to eq('Unauthorized')
        end
      end
      context "with valid access_token" do
        context "with valid parameters" do
          it "creates a new user" do
            expect {
              post users_url, params: { user: valid_attributes}, headers: api_headers
            }.to change(User, :count).by(1)
          end
    
          it "creates valid user" do
            post users_url, params: { user: valid_attributes }, headers: api_headers
            expect(User.where(email: valid_attributes['email']).count).to eq(1) 
            expect(response.status).to eq(201)
          end
        end
        context "with invalid parameters" do
          it "does not create a new user" do
            expect {
              post users_url, params: { user: invalid_attributes }, headers: api_headers
            }.to change(User, :count).by(0)
          end
    
          it "renders error message" do
            post users_url, params: { user: invalid_attributes }, headers: api_headers
            expect(response.status).to eq(422)
            expect(response.body).to include('email', 'invalid')
          end
        end
      end
    end
  
    describe "DELETE /destroy" do
      context "with invalid access token" do
        it "renders unauthorized" do
          user = User.create! valid_attributes
          delete user_url(user), headers: {'Authorization': 'Bearer wrong-api-key'}
          expect(response.status).to eq(401)
          expect(response.message).to eq('Unauthorized')
        end
      end
      context "with invalid access token" do
        it "destroys the requested user" do
          user = User.create! valid_attributes
          expect {
            delete user_url(user), headers: api_headers
          }.to change(User, :count).by(-1)
        end
    
        it "renders correct response code" do
          user = User.create! valid_attributes
          delete user_url(user), headers: api_headers
          expect(response.status).to eq(204)
        end
      end
    end
  end