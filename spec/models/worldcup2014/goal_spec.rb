require "rails_helper"

RSpec.describe Worldcup2014::Goal, type: :model do
  it { is_expected.to validate_presence_of(:id).on(:update) }
  it { is_expected.to validate_uniqueness_of(:id).on(:update) }
  it { is_expected.to validate_presence_of(:player_id) }
  it { is_expected.to belong_to(:player) }
  it { is_expected.to validate_presence_of(:pairing_id) }
  it { is_expected.to belong_to(:pairing) }
end
