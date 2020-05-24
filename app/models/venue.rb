# frozen_string_literal: true

class Venue
  include ActiveModel::Model

  attr_accessor :rows, :columns

  validates :rows, :columns, presence: true, numericality: { greater_than: 0 }
end