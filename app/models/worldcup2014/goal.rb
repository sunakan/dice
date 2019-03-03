class Worldcup2014::Goal < Worldcup2014::AppRecord
  validates :id, presence: true, on: :update
  validates :id, uniqueness: true, on: :update
  validates :pairing_id, presence: true
  validates :goal_time, presence: true
  validates :goal_time, length: { in: 1..10 }

  belongs_to :player, optional: true
  belongs_to :pairing
end
