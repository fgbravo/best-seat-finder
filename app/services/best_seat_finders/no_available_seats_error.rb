# frozen_string_literal: true

module BestSeatFinders
  class NoAvailableSeatsError < StandardError
    def message
      "There are no available seats."
    end
  end
end
