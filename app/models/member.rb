class Member < ApplicationRecord
  validates :member_id, presence: { message: "nilは許可しません" }
  validates :member_id, uniqueness: { message: "重複は許可しません" }
  validates :name, presence: { message: "nilは許可しません" }
end
