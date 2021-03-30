require 'rails_helper'

RSpec.describe "Weathers", type: :request do

  let(:valid_params) { { lat: 12.87, lng: 122.98 } }
  let(:invalid_params) { { lat: 12.87 } }

  let(:api_headers) { {'Authorization': 'Bearer some-api-key'}}

  describe "GET /weather/current" do
    context "when correct access token" do
      context "with valid request params" do
        it "returns valid response" do
          get '/weather/current', params: valid_params, headers: api_headers
          expect(response.status).to eq(200)
        end
      end
      context "with invalid request params" do
        it "renders bad request" do
          get '/weather/current', params: invalid_params, headers: api_headers
          expect(response.status).to eq(400)
          expect(response.message).to eq('Bad Request')
        end
      end
    end
    context "with incorrect access token" do
      it "renders unauthorized" do
        get '/weather/current', params: valid_params, headers: {}
        expect(response.status).to eq(401)
        expect(response.message).to eq('Unauthorized')
      end
    end
  end

  describe "GET /weather/forecast" do
    context "when correct access token" do
      context "with valid request params" do
        it "returns valid response" do
          get '/weather/forecast', params: valid_params, headers: api_headers
          expect(response.status).to eq(200)
        end
      end
      context "with invalid request params" do
        it "renders bad request" do
          get '/weather/forecast', params: invalid_params, headers: api_headers
          expect(response.status).to eq(400)
          expect(response.message).to eq('Bad Request')
        end
      end
    end
    context "with incorrect access token" do
      it "renders unauthorized" do
        get '/weather/forecast', params: valid_params, headers: {}
        expect(response.status).to eq(401)
        expect(response.message).to eq('Unauthorized')
      end
    end
  end
end
