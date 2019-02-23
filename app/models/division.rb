class Division < ApplicationRecord
  validates :division_id, presence: { message: "nilは許可しません" }
  validates :division_id, uniqueness: { message: "重複は許可しません" }
  validates :division_name, presence: { message: "nilは許可しません" }
end
