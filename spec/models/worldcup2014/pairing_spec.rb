require "rails_helper"

RSpec.describe Worldcup2014::Pairing, type: :model do
  it { is_expected.to validate_presence_of(:id).on(:update) }
  it { is_expected.to validate_uniqueness_of(:id).on(:update) }
  it { is_expected.to validate_presence_of(:kickoff) }
  it { is_expected.to validate_presence_of(:my_country_id) }
  it { is_expected.to validate_presence_of(:enemy_country_id) }
  it { is_expected.to belong_to(:my_country) }
  it { is_expected.to belong_to(:enemy_country) }
end
