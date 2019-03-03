class Worldcup2014::Goal < Worldcup2014::AppRecord
  validates :id, presence: true, on: :update
  validates :id, uniqueness: true, on: :update
  validates :pairing_id, presence: true
  validates :player_id, presence: true

  belongs_to :player
  belongs_to :pairing
end
