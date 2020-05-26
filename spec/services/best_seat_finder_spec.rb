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

        expect(service.find).to include(seat_a1)
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

        expect(service.find).to include(seat_f8)
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

            expect(service.find).to include(seat_f6)
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

            expect(service.find).to include(seat_f7)
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

            expect(service.find).to include(seat_f12)
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

            expect(service.find).to include(seat_f9)
          end
        end
      end
    end

    context "when multiple requested seats" do
      context "when available seats is lower than requested seats" do
        it "returns error when no available seats" do
          venue = Venue.new(rows: 10, columns: 12)

          seat_f1 = Seat.new(
            id: "f1",
            row: "f",
            column: 1,
            status: "AVAILABLE"
          )

          seat_g4 = Seat.new(
            id: "g4",
            row: "g",
            column: 4,
            status: "AVAILABLE"
          )

          seat_h10 = Seat.new(
            id: "h10",
            row: "h",
            column: 10,
            status: "AVAILABLE"
          )

          seats = [seat_h10, seat_g4, seat_f1]

          requested_seats = 2

          service = described_class.new(venue, seats, requested_seats)

          expect { service.find }.to raise_error BestSeatFinders::NoAvailableSeatsError
        end
      end

      context "when available seats are sequential and are equal to requested seats" do
        it "returns best available seats from venue" do
          venue = Venue.new(rows: 10, columns: 12)

          seat_f1 = Seat.new(
            id: "f1",
            row: "f",
            column: 1,
            status: "AVAILABLE"
          )

          seat_f2 = Seat.new(
            id: "f2",
            row: "f",
            column: 2,
            status: "AVAILABLE"
          )

          seat_h10 = Seat.new(
            id: "h10",
            row: "h",
            column: 10,
            status: "AVAILABLE"
          )

          seats = [seat_h10, seat_f2, seat_f1]

          requested_seats = 2

          service = described_class.new(venue, seats, requested_seats)

          expect(service.find).to include(seat_f1, seat_f2)
        end
      end

      context "when available seats are sequential and are not equal to requested seats" do
        it "returns best available seats from venue" do
          venue = Venue.new(rows: 10, columns: 12)

          seat_a1 = Seat.new(
            id: "a1",
            row: "a",
            column: 1,
            status: "AVAILABLE"
          )

          seat_f1 = Seat.new(
            id: "f1",
            row: "f",
            column: 1,
            status: "AVAILABLE"
          )

          seat_f2 = Seat.new(
            id: "f2",
            row: "f",
            column: 2,
            status: "AVAILABLE"
          )

          seat_f3 = Seat.new(
            id: "f3",
            row: "f",
            column: 3,
            status: "AVAILABLE"
          )

          seat_f5 = Seat.new(
            id: "f5",
            row: "f",
            column: 5,
            status: "AVAILABLE"
          )

          seats = [seat_f1, seat_f2, seat_f3, seat_f5, seat_a1]

          requested_seats = 2

          service = described_class.new(venue, seats, requested_seats)

          expect(service.find).to include(seat_f2, seat_f3)
        end
      end
    end
  end

  describe "#sequential_available_seats_for_row row" do
    it "returns true if sequential available seats is equal to two requested seats" do
      seat_a1 = Seat.new(
        id: "a1",
        row: "a",
        column: 1,
        status: "AVAILABLE"
      )

      seat_a2 = Seat.new(
        id: "a2",
        row: "a",
        column: 2,
        status: "AVAILABLE"
      )

      seat_a7 = Seat.new(
        id: "a7",
        row: "a",
        column: 7,
        status: "AVAILABLE"
      )

      row = [seat_a1, seat_a2, seat_a7]

      requested_seats = 2

      service = described_class.new(nil, nil, requested_seats)

      expect(service.sequential_available_seats_for_row(row)).to be true
    end

    it "returns false if no sequential seats available is equal to requested seats" do
      seat_a1 = Seat.new(
        id: "a1",
        row: "a",
        column: 1,
        status: "AVAILABLE"
      )

      seat_a5 = Seat.new(
        id: "a5",
        row: "a",
        column: 5,
        status: "AVAILABLE"
      )

      seat_a7 = Seat.new(
        id: "a7",
        row: "a",
        column: 7,
        status: "AVAILABLE"
      )

      row = [seat_a1, seat_a5, seat_a7]

      requested_seats = 2

      service = described_class.new(nil, nil, requested_seats)

      expect(service.sequential_available_seats_for_row(row)).to be false
    end

    it "returns true if sequential available seats is equal to requested one seat" do
      seat_a1 = Seat.new(
        id: "a1",
        row: "a",
        column: 1,
        status: "AVAILABLE"
      )

      seat_a5 = Seat.new(
        id: "a5",
        row: "a",
        column: 5,
        status: "AVAILABLE"
      )

      seat_a7 = Seat.new(
        id: "a7",
        row: "a",
        column: 7,
        status: "AVAILABLE"
      )

      row = [seat_a1, seat_a5, seat_a7]

      requested_seats = 1

      service = described_class.new(nil, nil, requested_seats)

      expect(service.sequential_available_seats_for_row(row)).to be true
    end

    it "returns true if sequential available seats is equal to three requested seats" do
      seat_a1 = Seat.new(
        id: "a1",
        row: "a",
        column: 1,
        status: "AVAILABLE"
      )

      seat_a2 = Seat.new(
        id: "a2",
        row: "a",
        column: 2,
        status: "AVAILABLE"
      )

      seat_a3 = Seat.new(
        id: "a3",
        row: "a",
        column: 3,
        status: "AVAILABLE"
      )

      row = [seat_a1, seat_a2, seat_a3]

      requested_seats = 3

      service = described_class.new(nil, nil, requested_seats)

      expect(service.sequential_available_seats_for_row(row)).to be true
    end
  end

  describe "#possible_sets row" do
    it "returns possible sets of seats for the first example with one requested seat" do
      seat_a1 = Seat.new(
        id: "a1",
        row: "a",
        column: 1,
        status: "AVAILABLE"
      )

      seat_a2 = Seat.new(
        id: "a2",
        row: "a",
        column: 2,
        status: "AVAILABLE"
      )

      seat_a3 = Seat.new(
        id: "a3",
        row: "a",
        column: 3,
        status: "AVAILABLE"
      )

      seat_a4 = Seat.new(
        id: "a4",
        row: "a",
        column: 4,
        status: "AVAILABLE"
      )

      seat_a5 = Seat.new(
        id: "a5",
        row: "a",
        column: 5,
        status: "AVAILABLE"
      )

      seat_a6 = Seat.new(
        id: "a6",
        row: "a",
        column: 6,
        status: "AVAILABLE"
      )

      seat_a7 = Seat.new(
        id: "a7",
        row: "a",
        column: 7,
        status: "AVAILABLE"
      )

      seat_a8 = Seat.new(
        id: "a8",
        row: "a",
        column: 8,
        status: "AVAILABLE"
      )

      seat_a9 = Seat.new(
        id: "a9",
        row: "a",
        column: 9,
        status: "AVAILABLE"
      )

      seat_a10 = Seat.new(
        id: "a10",
        row: "a",
        column: 10,
        status: "AVAILABLE"
      )

      seat_a11 = Seat.new(
        id: "a11",
        row: "a",
        column: 11,
        status: "AVAILABLE"
      )

      seat_a12 = Seat.new(
        id: "a12",
        row: "a",
        column: 12,
        status: "AVAILABLE"
      )

      row = [seat_a1, seat_a2, seat_a3, seat_a4, seat_a5, seat_a6, seat_a7, seat_a8, seat_a9, seat_a10, seat_a11, seat_a12]

      requested_seats = 1

      service = described_class.new(nil, nil, requested_seats)

      expect(service.possible_sets(row)).to include([seat_a1], [seat_a2], [seat_a3], [seat_a4], [seat_a5], [seat_a6], [seat_a7], [seat_a8], [seat_a9], [seat_a10], [seat_a11], [seat_a12])
    end

    it "returns possible sets of seats for the first example with three requested seat" do
      seat_a1 = Seat.new(
        id: "a1",
        row: "a",
        column: 1,
        status: "AVAILABLE"
      )

      seat_a2 = Seat.new(
        id: "a2",
        row: "a",
        column: 2,
        status: "AVAILABLE"
      )

      seat_a3 = Seat.new(
        id: "a3",
        row: "a",
        column: 3,
        status: "AVAILABLE"
      )

      seat_a4 = Seat.new(
        id: "a4",
        row: "a",
        column: 4,
        status: "AVAILABLE"
      )

      seat_a5 = Seat.new(
        id: "a5",
        row: "a",
        column: 5,
        status: "AVAILABLE"
      )

      seat_a6 = Seat.new(
        id: "a6",
        row: "a",
        column: 6,
        status: "AVAILABLE"
      )

      seat_a7 = Seat.new(
        id: "a7",
        row: "a",
        column: 7,
        status: "AVAILABLE"
      )

      seat_a8 = Seat.new(
        id: "a8",
        row: "a",
        column: 8,
        status: "AVAILABLE"
      )

      seat_a9 = Seat.new(
        id: "a9",
        row: "a",
        column: 9,
        status: "AVAILABLE"
      )

      seat_a10 = Seat.new(
        id: "a10",
        row: "a",
        column: 10,
        status: "AVAILABLE"
      )

      seat_a11 = Seat.new(
        id: "a11",
        row: "a",
        column: 11,
        status: "AVAILABLE"
      )

      seat_a12 = Seat.new(
        id: "a12",
        row: "a",
        column: 12,
        status: "AVAILABLE"
      )

      row = [seat_a1, seat_a2, seat_a3, seat_a4, seat_a5, seat_a6, seat_a7, seat_a8, seat_a9, seat_a10, seat_a11, seat_a12]

      requested_seats = 3

      service = described_class.new(nil, nil, requested_seats)

      expect(service.possible_sets(row)).to include([seat_a1, seat_a2, seat_a3],
                                                    [seat_a2, seat_a3, seat_a4],
                                                    [seat_a3, seat_a4, seat_a5],
                                                    [seat_a4, seat_a5, seat_a6],
                                                    [seat_a5, seat_a6, seat_a7],
                                                    [seat_a6, seat_a7, seat_a8],
                                                    [seat_a7, seat_a8, seat_a9],
                                                    [seat_a8, seat_a9, seat_a10],
                                                    [seat_a9, seat_a10, seat_a11],
                                                    [seat_a10, seat_a11, seat_a12])
    end
  end

  describe "#select_best_set set" do
    it "returns best seat for the first example with one requested seat" do
      venue = Venue.new(rows: 10, columns: 12)

      seat_a1 = Seat.new(
        id: "a1",
        row: "a",
        column: 1,
        status: "AVAILABLE"
      )

      seat_a2 = Seat.new(
        id: "a2",
        row: "a",
        column: 2,
        status: "AVAILABLE"
      )

      seat_a3 = Seat.new(
        id: "a3",
        row: "a",
        column: 3,
        status: "AVAILABLE"
      )

      seat_a4 = Seat.new(
        id: "a4",
        row: "a",
        column: 4,
        status: "AVAILABLE"
      )

      seat_a5 = Seat.new(
        id: "a5",
        row: "a",
        column: 5,
        status: "AVAILABLE"
      )

      seat_a6 = Seat.new(
        id: "a6",
        row: "a",
        column: 6,
        status: "AVAILABLE"
      )

      seat_a7 = Seat.new(
        id: "a7",
        row: "a",
        column: 7,
        status: "AVAILABLE"
      )

      seat_a8 = Seat.new(
        id: "a8",
        row: "a",
        column: 8,
        status: "AVAILABLE"
      )

      seat_a9 = Seat.new(
        id: "a9",
        row: "a",
        column: 9,
        status: "AVAILABLE"
      )

      seat_a10 = Seat.new(
        id: "a10",
        row: "a",
        column: 10,
        status: "AVAILABLE"
      )

      seat_a11 = Seat.new(
        id: "a11",
        row: "a",
        column: 11,
        status: "AVAILABLE"
      )

      seat_a12 = Seat.new(
        id: "a12",
        row: "a",
        column: 12,
        status: "AVAILABLE"
      )

      sets = [[seat_a1], [seat_a2], [seat_a3], [seat_a4], [seat_a5], [seat_a6], [seat_a7], [seat_a8], [seat_a9], [seat_a10], [seat_a11], [seat_a12]]

      requested_seats = 1

      service = described_class.new(venue, nil, requested_seats)

      expect(service.select_best_set(sets)).to include(seat_a6)
    end

    it "returns best seats for the first example with three requested seats" do
      venue = Venue.new(rows: 10, columns: 12)

      seat_a1 = Seat.new(
        id: "a1",
        row: "a",
        column: 1,
        status: "AVAILABLE"
      )

      seat_a2 = Seat.new(
        id: "a2",
        row: "a",
        column: 2,
        status: "AVAILABLE"
      )

      seat_a3 = Seat.new(
        id: "a3",
        row: "a",
        column: 3,
        status: "AVAILABLE"
      )

      seat_a4 = Seat.new(
        id: "a4",
        row: "a",
        column: 4,
        status: "AVAILABLE"
      )

      seat_a5 = Seat.new(
        id: "a5",
        row: "a",
        column: 5,
        status: "AVAILABLE"
      )

      seat_a6 = Seat.new(
        id: "a6",
        row: "a",
        column: 6,
        status: "AVAILABLE"
      )

      seat_a7 = Seat.new(
        id: "a7",
        row: "a",
        column: 7,
        status: "AVAILABLE"
      )

      seat_a8 = Seat.new(
        id: "a8",
        row: "a",
        column: 8,
        status: "AVAILABLE"
      )

      seat_a9 = Seat.new(
        id: "a9",
        row: "a",
        column: 9,
        status: "AVAILABLE"
      )

      seat_a10 = Seat.new(
        id: "a10",
        row: "a",
        column: 10,
        status: "AVAILABLE"
      )

      seat_a11 = Seat.new(
        id: "a11",
        row: "a",
        column: 11,
        status: "AVAILABLE"
      )

      seat_a12 = Seat.new(
        id: "a12",
        row: "a",
        column: 12,
        status: "AVAILABLE"
      )

      sets = [[seat_a1, seat_a2, seat_a3],
          [seat_a2, seat_a3, seat_a4],
          [seat_a3, seat_a4, seat_a5],
          [seat_a4, seat_a5, seat_a6],
          [seat_a5, seat_a6, seat_a7],
          [seat_a6, seat_a7, seat_a8],
          [seat_a7, seat_a8, seat_a9],
          [seat_a8, seat_a9, seat_a10],
          [seat_a9, seat_a10, seat_a11],
          [seat_a10, seat_a11, seat_a12]]

      requested_seats = 3

      service = described_class.new(venue, nil, requested_seats)

      expect(service.select_best_set(sets)).to include(seat_a5, seat_a6, seat_a7)
    end

    it "returns best seats for the second example with two requested seats" do
      venue = Venue.new(rows: 12, columns: 5)

      seat_b1 = Seat.new(
        id: "b1",
        row: "b",
        column: 1,
        status: "AVAILABLE"
      )

      seat_b2 = Seat.new(
        id: "b2",
        row: "b",
        column: 2,
        status: "AVAILABLE"
      )

      seat_b3 = Seat.new(
        id: "b3",
        row: "b",
        column: 3,
        status: "AVAILABLE"
      )

      seat_b4 = Seat.new(
        id: "b4",
        row: "b",
        column: 4,
        status: "AVAILABLE"
      )

      seat_b5 = Seat.new(
        id: "b5",
        row: "b",
        column: 5,
        status: "AVAILABLE"
      )

      sets = [[seat_b1, seat_b2],
              [seat_b2, seat_b3],
              [seat_b3, seat_b4],
              [seat_b4, seat_b5]]

      requested_seats = 2

      service = described_class.new(venue, nil, requested_seats)

      expect(service.select_best_set(sets)).to include(seat_b2, seat_b3)
    end

    it "returns best seats with four requested seats" do
      venue = Venue.new(rows: 10, columns: 12)

      seat_a3 = Seat.new(
        id: "a3",
        row: "a",
        column: 3,
        status: "AVAILABLE"
      )

      seat_b3 = Seat.new(
        id: "b3",
        row: "b",
        column: 3,
        status: "AVAILABLE"
      )

      seat_b4 = Seat.new(
        id: "b4",
        row: "b",
        column: 4,
        status: "AVAILABLE"
      )

      seat_b5 = Seat.new(
        id: "b5",
        row: "b",
        column: 5,
        status: "AVAILABLE"
      )

      seat_b6 = Seat.new(
        id: "b6",
        row: "b",
        column: 6,
        status: "AVAILABLE"
      )

      seat_b7 = Seat.new(
        id: "b7",
        row: "b",
        column: 7,
        status: "AVAILABLE"
      )

      seat_b8 = Seat.new(
        id: "b8",
        row: "b",
        column: 8,
        status: "AVAILABLE"
      )

      seat_b9 = Seat.new(
        id: "b9",
        row: "b",
        column: 9,
        status: "AVAILABLE"
      )

      sets = [[seat_b3, seat_b4, seat_b5, seat_b6],
              [seat_b4, seat_b5, seat_b6, seat_b7],
              [seat_b5, seat_b6, seat_b7, seat_b8],
              [seat_b6, seat_b7, seat_b8, seat_b9]]

      requested_seats = 4

      service = described_class.new(venue, nil, requested_seats)

      expect(service.select_best_set(sets)).to include(seat_b4, seat_b5, seat_b6, seat_b7)
    end
  end
end
