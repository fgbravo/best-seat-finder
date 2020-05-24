# frozen_string_literal: true

require "rails_helper"

RSpec.describe Venue, type: :model do
  context "validations" do
    it { should validate_presence_of(:rows) }
    it { should validate_presence_of(:columns) }

    it { should validate_numericality_of(:rows).is_greater_than(0) }
    it { should validate_numericality_of(:columns).is_greater_than(0) }
  end
end