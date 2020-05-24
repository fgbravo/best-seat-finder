# frozen_string_literal: true

class Seat
  include ActiveModel::Model

  attr_accessor :id, :row, :column, :status

  with_options presence: true do
    validates :id, :status
    validates :row, inclusion: { in: "a".."z" }
    validates :column, numericality: { greater_than: 0 }
  end
end