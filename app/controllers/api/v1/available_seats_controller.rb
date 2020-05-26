# frozen_string_literal: true

module API
  module V1
    class AvailableSeatsController < ApplicationController
      before_action :entities_params, only: :create

      def create
        entities = EntitiesBuilder.new(entities_params)
        result = BestSeatFinder.new(entities.venue, entities.available_seats, entities.requested_seats).find
        render json: result, status: :ok
      end

      private
      def entities_params
        params.permit!
      end
    end
  end
end