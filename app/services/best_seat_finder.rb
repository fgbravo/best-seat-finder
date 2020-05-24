# frozen_string_literal: true

class BestSeatFinder
  def initialize(venue, seats, requested_seats)
    @venue = venue
    @seats = seats
    @requested_seats = requested_seats
  end

  def find
    ordered_seats = @seats.sort_by do |seat|
      [seat.row, seat.column]
    end
    selected_row = ordered_seats.group_by(&:row).first
    selected_row.last.min do |row_seat, next_row_seat|

      best_seat_position = (@venue.columns / 2).floor
      (best_seat_position - row_seat.column).abs <=> (best_seat_position - next_row_seat.column).abs
    end
  end
end
