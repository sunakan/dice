require "rails_helper"

RSpec.describe Worldcup2014::Player, type: :model do
  it { is_expected.to validate_presence_of(:id).on(:update) }
  it { is_expected.to validate_uniqueness_of(:id).on(:update) }
  it { is_expected.to validate_presence_of(:country_id).on(:create) }
  it { is_expected.to validate_numericality_of(:country_id).is_greater_than_or_equal_to(0) }
  it { is_expected.to belong_to(:country) }
  it { is_expected.to validate_presence_of(:uniform_num) }
  it { is_expected.to validate_numericality_of(:uniform_num).is_greater_than_or_equal_to(0) }
  it { is_expected.to validate_presence_of(:position) }
  it { is_expected.to validate_length_of(:position).is_equal_to(2) }
  it { is_expected.to validate_inclusion_of(:position).in_array(Worldcup2014::Player::Position.all) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(1).is_at_most(50) }
  it { is_expected.to validate_presence_of(:club) }
  it { is_expected.to validate_length_of(:club).is_at_least(1).is_at_most(50) }
  it { is_expected.to validate_presence_of(:birth) }
  it { is_expected.to validate_presence_of(:height) }
  it { is_expected.to validate_numericality_of(:height).is_greater_than_or_equal_to(0).only_integer }
  it { is_expected.to validate_presence_of(:weight) }
  it { is_expected.to validate_numericality_of(:weight).is_greater_than_or_equal_to(0).only_integer }
end
