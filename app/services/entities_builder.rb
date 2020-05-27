# frozen_string_literal: true

class EntitiesBuilder
  def initialize(params)
    @venue_params = params.dig(:venue, :layout)
    @seats_params = params.dig(:seats).to_h
    @requested_seats = params.dig(:requested_seats).to_i
  end

  def venue
    @venue ||= Venue.new(@venue_params.slice(:rows, :columns))

    if @venue.valid?
      @venue
    else
      raise EntitiesBuilders::InvalidVenueError
    end
  end

  def available_seats
    available_seats = []
    @seats_params.each do |_id, seat_params|
      validate_seat(seat_params)
      available_seats << build_seat(seat_params)
    end
    available_seats
  end

  def requested_seats
    if @requested_seats > 0
      @requested_seats
    else
      raise EntitiesBuilders::InvalidRequestedSeatError
    end
  end

  private
  def validate_seat(seat_params)
    seat = Seat.new(seat_params)
    raise EntitiesBuilders::InvalidSeatError unless seat.valid?
  end

  def build_seat(seat_params)
    Seat.new(seat_params)
  end
end