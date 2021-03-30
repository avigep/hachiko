require 'rails_helper'

RSpec.describe "Tokens", type: :request do
    let(:valid_attributes) { {
         "scopes": ['weather:read'],
         "user_id": User.first.id
      } 
    }
    let(:invalid_attributes) { { "scopes": ["users:delete"] } }
  
    let(:api_headers) { {'Authorization': 'Bearer some-api-key'}}

    describe "POST /tokens" do
      context "with invalid access token" do
        it "renders unauthorized" do
          post tokens_url, params: { token: valid_attributes }, headers: {}
          expect(response.status).to eq(401)
          expect(response.message).to eq('Unauthorized')
        end
      end
      context "with valid access_token" do
        context "with valid parameters" do
          it "creates a new token" do
            expect {
              post tokens_url, params: { token: valid_attributes}, headers: api_headers
            }.to change(Token, :count).by(1)
          end
    
          it "creates valid token" do
            post tokens_url, params: { token: valid_attributes }, headers: api_headers
            expect(response.status).to eq(201)
            expect(JSON.parse(response.body)['scopes']).to eq(['weather:read'])
          end
        end
        context "with invalid parameters" do
          it "does not create a new token" do
            expect {
              post tokens_url, params: { token: invalid_attributes }, headers: api_headers
            }.to change(Token, :count).by(0)
          end
    
          it "renders error message" do
            post tokens_url, params: { token: invalid_attributes }, headers: api_headers
            expect(response.status).to eq(422)
            expect(response.body).to include('Use valid api scopes from')
          end
        end
      end
    end
  
    describe "DELETE /destroy" do
      context "with invalid access token" do
        it "renders unauthorized" do
          token = Token.create! valid_attributes
          delete token_url(token), headers: {'Authorization': 'Bearer wrong-api-key'}
          expect(response.status).to eq(401)
          expect(response.message).to eq('Unauthorized')
        end
      end
      context "with invalid access token" do
        it "destroys the requested user" do
          token = Token.create! valid_attributes
          expect {
            delete token_url(token), headers: api_headers
          }.to change(Token, :count).by(-1)
        end
    
        it "renders correct response code" do
          token = Token.create! valid_attributes
          delete token_url(token), headers: api_headers
          expect(response.status).to eq(204)
        end
      end
    end
  end