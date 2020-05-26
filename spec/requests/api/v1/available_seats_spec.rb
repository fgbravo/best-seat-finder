# frozen_string_literal: true

require "rails_helper"

RSpec.describe "POST api/v1/available_seats", type: :request do
  describe "#create params" do
    context "using test example" do
      let(:params) { {
          "venue": {
              "layout": {
                  "rows": 10,
                  "columns": 50
              }
          },
          "seats": {
              "a1": {
                  "id": "a1",
                  "row": "a",
                  "column": 1,
                  "status": "AVAILABLE"
              },
              "b5": {
                  "id": "b5",
                  "row": "b",
                  "column": 5,
                  "status": "AVAILABLE"
              },
              "h7": {
                  "id": "h7",
                  "row": "h",
                  "column": 7,
                  "status": "AVAILABLE"
              }
          },
          "requested_seats": 1
      } }

      before { post api_v1_available_seats_path, params: params }

      it "should return status code :ok" do
        expect(response).to have_http_status(:ok)
      end

      it "should return seat a1" do
        expect(response.body).to eql("[{\"id\":\"a1\",\"row\":\"a\",\"column\":\"1\",\"status\":\"AVAILABLE\"}]")
      end
    end
  end
end
