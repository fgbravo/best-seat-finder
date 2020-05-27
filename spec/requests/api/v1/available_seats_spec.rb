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
        expect(JSON.parse(response.body)).to eql([{ "column" => "1", "id" => "a1", "row" => "a", "status" => "AVAILABLE" }])
      end
    end

    context "messing with other requests" do
      context "with valid params" do
        let(:params) { {
            "venue": {
                "layout": {
                    "rows": 10,
                    "columns": 12
                }
            },
            "seats": {
                "a1": {
                    "id": "a1",
                    "row": "a",
                    "column": 1,
                    "status": "AVAILABLE"
                },
                "b1": {
                    "id": "b1",
                    "row": "b",
                    "column": 1,
                    "status": "AVAILABLE"
                },
                "b2": {
                    "id": "b2",
                    "row": "b",
                    "column": 2,
                    "status": "AVAILABLE"
                },
                "b3": {
                    "id": "b3",
                    "row": "b",
                    "column": 3,
                    "status": "AVAILABLE"
                },
                "b4": {
                    "id": "b4",
                    "row": "b",
                    "column": 4,
                    "status": "AVAILABLE"
                },
                "b5": {
                    "id": "b5",
                    "row": "b",
                    "column": 5,
                    "status": "AVAILABLE"
                },
                "a2": {
                    "id": "a2",
                    "row": "a",
                    "column": 2,
                    "status": "AVAILABLE"
                }
            },
            "requested_seats": 3
        } }

        before { post api_v1_available_seats_path, params: params }

        it "should return status :ok" do
          expect(response).to have_http_status(:ok)
        end

        it "should return seats b3, b4 and b5" do
          expect(JSON.parse(response.body)).to eql([{ "column" => "3", "id" => "b3", "row" => "b", "status" => "AVAILABLE" },
                                                    { "column" => "4", "id" => "b4", "row" => "b", "status" => "AVAILABLE" },
                                                    { "column" => "5", "id" => "b5", "row" => "b", "status" => "AVAILABLE" }])
        end
      end

      context "when there are not enough seats" do
        let(:params) { {
            "venue": {
                "layout": {
                    "rows": 10,
                    "columns": 12
                }
            },
            "seats": {
                "a1": {
                    "id": "a1",
                    "row": "a",
                    "column": 1,
                    "status": "AVAILABLE"
                },
                "b1": {
                    "id": "b1",
                    "row": "b",
                    "column": 1,
                    "status": "AVAILABLE"
                },
                "b2": {
                    "id": "b2",
                    "row": "b",
                    "column": 2,
                    "status": "AVAILABLE"
                },
                "b3": {
                    "id": "b3",
                    "row": "b",
                    "column": 3,
                    "status": "AVAILABLE"
                },
                "b4": {
                    "id": "b4",
                    "row": "b",
                    "column": 4,
                    "status": "AVAILABLE"
                },
                "b5": {
                    "id": "b5",
                    "row": "b",
                    "column": 5,
                    "status": "AVAILABLE"
                },
                "a2": {
                    "id": "a2",
                    "row": "a",
                    "column": 2,
                    "status": "AVAILABLE"
                }
            },
            "requested_seats": 6
        } }

        before { post api_v1_available_seats_path, params: params }

        it "should return status :not_found" do
          expect(response).to have_http_status(:not_found)
        end

        it "should return error message" do
          expect(response.body).to eql("There are no available seats.")
        end
      end

      context "with invalid params" do
        context "with invalid venue" do
          let(:params) { {
              "venue": {
                  "layout": {
                      "rows": -1,
                      "columns": 0
                  }
              },
              "seats": {
                  "a1": {
                      "id": "a1",
                      "row": "a",
                      "column": 1,
                      "status": "AVAILABLE"
                  },
                  "b1": {
                      "id": "b1",
                      "row": "b",
                      "column": 1,
                      "status": "AVAILABLE"
                  },
                  "b2": {
                      "id": "b2",
                      "row": "b",
                      "column": 2,
                      "status": "AVAILABLE"
                  },
                  "b3": {
                      "id": "b3",
                      "row": "b",
                      "column": 3,
                      "status": "AVAILABLE"
                  },
                  "b4": {
                      "id": "b4",
                      "row": "b",
                      "column": 4,
                      "status": "AVAILABLE"
                  },
                  "b5": {
                      "id": "b5",
                      "row": "b",
                      "column": 5,
                      "status": "AVAILABLE"
                  },
                  "a2": {
                      "id": "a2",
                      "row": "a",
                      "column": 2,
                      "status": "AVAILABLE"
                  }
              },
              "requested_seats": 1
          } }

          before { post api_v1_available_seats_path, params: params }

          it "should return status :unprocessable_entity" do
            expect(response).to have_http_status(:unprocessable_entity)
          end

          it "should return error message" do
            expect(response.body).to eql("Venue rows and columns must be greater than 0")
          end
        end

        context "with invalid requested seats" do
          let(:params) { {
              "venue": {
                  "layout": {
                      "rows": 10,
                      "columns": 12
                  }
              },
              "seats": {
                  "a1": {
                      "id": "a1",
                      "row": "a",
                      "column": 1,
                      "status": "AVAILABLE"
                  },
                  "b1": {
                      "id": "b1",
                      "row": "b",
                      "column": 1,
                      "status": "AVAILABLE"
                  },
                  "b2": {
                      "id": "b2",
                      "row": "b",
                      "column": 2,
                      "status": "AVAILABLE"
                  },
                  "b3": {
                      "id": "b3",
                      "row": "b",
                      "column": 3,
                      "status": "AVAILABLE"
                  },
                  "b4": {
                      "id": "b4",
                      "row": "b",
                      "column": 4,
                      "status": "AVAILABLE"
                  },
                  "b5": {
                      "id": "b5",
                      "row": "b",
                      "column": 5,
                      "status": "AVAILABLE"
                  },
                  "a2": {
                      "id": "a2",
                      "row": "a",
                      "column": 2,
                      "status": "AVAILABLE"
                  }
              },
              "requested_seats": 0
          } }

          before { post api_v1_available_seats_path, params: params }

          it "should return status :unprocessable_entity" do
            expect(response).to have_http_status(:unprocessable_entity)
          end

          it "should return error message" do
            expect(response.body).to eql("Requested seats must be greater than 0")
          end
        end

        context "with invalid seat" do
          let(:params) { {
              "venue": {
                  "layout": {
                      "rows": 10,
                      "columns": 12
                  }
              },
              "seats": {
                  "a1": {
                      "id": nil,
                      "row": nil,
                      "column": nil,
                      "status": nil
                  },
                  "b1": {
                      "id": "b1",
                      "row": "b",
                      "column": 1,
                      "status": "AVAILABLE"
                  },
                  "b2": {
                      "id": "b2",
                      "row": "b",
                      "column": 2,
                      "status": "AVAILABLE"
                  },
                  "b3": {
                      "id": "b3",
                      "row": "b",
                      "column": 3,
                      "status": "AVAILABLE"
                  },
                  "b4": {
                      "id": "b4",
                      "row": "b",
                      "column": 4,
                      "status": "AVAILABLE"
                  },
                  "b5": {
                      "id": "b5",
                      "row": "b",
                      "column": 5,
                      "status": "AVAILABLE"
                  },
                  "a2": {
                      "id": "a2",
                      "row": "a",
                      "column": 2,
                      "status": "AVAILABLE"
                  }
              },
              "requested_seats": 1
          } }

          before { post api_v1_available_seats_path, params: params }

          it "should return status :unprocessable_entity" do
            expect(response).to have_http_status(:unprocessable_entity)
          end

          it "should return error message" do
            expect(response.body).to eql("Seats must contain ID, status, row and column. Row must be an alphabet letter and column must be greater than 0")
          end
        end
      end
    end
  end
end
