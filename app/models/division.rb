class Division < ApplicationRecord
  self.primary_key = "division_id"
  has_many :members, class_name: "Member", foreign_key: "division_id", inverse_of: :division, dependent: :nullify

  validates :division_id, presence: { message: "nilは許可しません" }
  validates :division_id, uniqueness: { message: "重複は許可しません" }
  validates :division_name, presence: { message: "nilは許可しません" }
end
