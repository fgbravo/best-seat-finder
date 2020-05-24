# frozen_string_literal: true

require "rails_helper"

RSpec.describe Seat, type: :model do
  context "validations" do
    it { should validate_presence_of(:id) }
    it { should validate_presence_of(:row) }
    it { should validate_presence_of(:column) }
    it { should validate_presence_of(:status) }

    it { should validate_inclusion_of(:row).in_array(("a".."z").to_a) }

    it { should validate_numericality_of(:column).is_greater_than(0) }
  end
end