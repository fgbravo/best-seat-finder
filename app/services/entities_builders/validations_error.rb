# frozen_string_literal: true

module EntitiesBuilders
  class ValidationsError < StandardError; end

  class InvalidVenueError < ValidationsError
    def message
      "Venue rows and columns must be greater than 0"
    end
  end

  class InvalidRequestedSeatError < ValidationsError
    def message
      "Requested seats must be greater than 0"
    end
  end

  class InvalidSeatError < ValidationsError
    def message
      "Seats must contain ID, status, row and column. Row must be an alphabet letter and column must be greater than 0"
    end
  end
end
