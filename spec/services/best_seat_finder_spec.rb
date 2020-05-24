# frozen_string_literal: true

require "rails_helper"

RSpec.describe BestSeatFinder do
  describe "#find" do
    context "when using provided information from test" do
      it "returns best available seat from venue" do
        venue = Venue.new(rows: 10, columns: 50)

        seat_a1 = Seat.new(
          id: "a1",
          row: "a",
          column: 1,
          status: "AVAILABLE"
        )

        seat_b5 = Seat.new(
          id: "b5",
          row: "b",
          column: 5,
          status: "AVAILABLE"
        )

        seat_h7 = Seat.new(
          id: "h7",
          row: "h",
          column: 7,
          status: "AVAILABLE"
        )

        seats = [seat_a1, seat_b5, seat_h7]

        requested_seats = 1

        service = described_class.new(venue, seats, requested_seats)

        expect(service.find).to eql(seat_a1)
      end
    end

    context "when messing around with other information" do
      it "returns best available seat from venue" do
        venue = Venue.new(rows: 10, columns: 50)

        seat_f8 = Seat.new(
          id: "f8",
          row: "f",
          column: 8,
          status: "AVAILABLE"
        )

        seat_h2 = Seat.new(
          id: "h2",
          row: "h",
          column: 2,
          status: "AVAILABLE"
        )

        seat_j10 = Seat.new(
          id: "j10",
          row: "j",
          column: 10,
          status: "AVAILABLE"
        )

        seats = [seat_j10, seat_h2, seat_f8]

        requested_seats = 1

        service = described_class.new(venue, seats, requested_seats)

        expect(service.find).to eql(seat_f8)
      end

      context "when there is more than one available seat in the same row" do

        context "when best seat position is equal to best seat" do
          it "returns best available seat from venue" do
            venue = Venue.new(rows: 10, columns: 12)

            seat_f1 = Seat.new(
              id: "f1",
              row: "f",
              column: 1,
              status: "AVAILABLE"
            )

            seat_f6 = Seat.new(
              id: "f6",
              row: "f",
              column: 6,
              status: "AVAILABLE"
            )

            seat_h10 = Seat.new(
              id: "h10",
              row: "h",
              column: 10,
              status: "AVAILABLE"
            )

            seats = [seat_h10, seat_f6, seat_f1]

            requested_seats = 1

            service = described_class.new(venue, seats, requested_seats)

            expect(service.find).to eql(seat_f6)
          end
        end

        context "when best seat position is higher than the best seat" do
          it "returns best available seat from venue" do
            venue = Venue.new(rows: 10, columns: 20)

            seat_f1 = Seat.new(
              id: "f1",
              row: "f",
              column: 1,
              status: "AVAILABLE"
            )

            seat_f5 = Seat.new(
              id: "f5",
              row: "f",
              column: 5,
              status: "AVAILABLE"
            )

            seat_f6 = Seat.new(
              id: "f6",
              row: "f",
              column: 6,
              status: "AVAILABLE"
            )

            seat_f7 = Seat.new(
              id: "f7",
              row: "f",
              column: 7,
              status: "AVAILABLE"
            )

            seat_h10 = Seat.new(
              id: "h10",
              row: "h",
              column: 10,
              status: "AVAILABLE"
            )

            seats = [seat_h10, seat_f6, seat_f1, seat_f5, seat_f7]

            requested_seats = 1

            service = described_class.new(venue, seats, requested_seats)

            expect(service.find).to eql(seat_f7)
          end
        end

        context "when best seat position is lower than the best seat" do
          it "returns best available seat from venue" do
            venue = Venue.new(rows: 10, columns: 20)

            seat_f12 = Seat.new(
              id: "f12",
              row: "f",
              column: 12,
              status: "AVAILABLE"
            )

            seat_f13 = Seat.new(
              id: "f13",
              row: "f",
              column: 13,
              status: "AVAILABLE"
            )

            seat_f17 = Seat.new(
              id: "f17",
              row: "f",
              column: 17,
              status: "AVAILABLE"
            )

            seat_f20 = Seat.new(
              id: "f20",
              row: "f",
              column: 20,
              status: "AVAILABLE"
            )

            seat_h10 = Seat.new(
              id: "h10",
              row: "h",
              column: 10,
              status: "AVAILABLE"
            )

            seats = [seat_f12, seat_f13, seat_f17, seat_f20, seat_h10]

            requested_seats = 1

            service = described_class.new(venue, seats, requested_seats)

            expect(service.find).to eql(seat_f12)
          end
        end

        context "when best seat position has two best possible seats" do
          it "returns the first best available seat from venue" do
            venue = Venue.new(rows: 10, columns: 20)

            seat_f9 = Seat.new(
              id: "f9",
              row: "f",
              column: 9,
              status: "AVAILABLE"
            )

            seat_f11 = Seat.new(
              id: "f11",
              row: "f",
              column: 11,
              status: "AVAILABLE"
            )

            seat_f17 = Seat.new(
              id: "f17",
              row: "f",
              column: 17,
              status: "AVAILABLE"
            )

            seat_f20 = Seat.new(
              id: "f20",
              row: "f",
              column: 20,
              status: "AVAILABLE"
            )

            seat_h10 = Seat.new(
              id: "h10",
              row: "h",
              column: 10,
              status: "AVAILABLE"
            )

            seats = [seat_f9, seat_f11, seat_f17, seat_f20, seat_h10]

            requested_seats = 1

            service = described_class.new(venue, seats, requested_seats)

            expect(service.find).to eql(seat_f9)
          end
        end
      end
    end
  end
end
