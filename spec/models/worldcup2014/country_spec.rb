require "rails_helper"

RSpec.describe Worldcup2014::Country, type: :model do
  it { is_expected.to validate_presence_of(:id).on(:update) }
  it { is_expected.to validate_uniqueness_of(:id).on(:update) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(1).is_at_most(50) }
  it { is_expected.to validate_presence_of(:ranking) }
  it { is_expected.to validate_numericality_of(:ranking).is_greater_than_or_equal_to(0).only_integer }
  it { is_expected.to validate_presence_of(:group_name) }
  it { is_expected.to validate_length_of(:group_name).is_equal_to(1) }
  it { is_expected.to validate_inclusion_of(:group_name).in_array(Worldcup2014::Country::Group.all) }

  it { is_expected.to have_many(:players) }
end
