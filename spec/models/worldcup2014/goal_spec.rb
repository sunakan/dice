require "rails_helper"

RSpec.describe Worldcup2014::Goal, type: :model do
  it { is_expected.to validate_presence_of(:id).on(:update) }
  it { is_expected.to validate_uniqueness_of(:id).on(:update) }
  it { is_expected.to belong_to(:player).optional }
  it { is_expected.to validate_presence_of(:pairing_id) }
  it { is_expected.to belong_to(:pairing) }
  it { is_expected.to validate_presence_of(:goal_time) }
  it { is_expected.to validate_length_of(:goal_time).is_at_least(1).is_at_most(10) }
end
