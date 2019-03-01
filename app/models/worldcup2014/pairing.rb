class Worldcup2014::Pairing < Worldcup2014::AppRecord
  validates :id, presence: true, on: :update
  validates :id, uniqueness: true, on: :update
  validates :kickoff, presence: true
  validates :my_country_id, presence: true
  validates :enemy_country_id, presence: true

  belongs_to :my_country, class_name: "Worldcup2014::Country"
  belongs_to :enemy_country, class_name: "Worldcup2014::Country"
end
