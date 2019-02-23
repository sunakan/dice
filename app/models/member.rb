# Note
# optional, inverse_of
# https://railsguides.jp/association_basics.html#optional
# https://railsguides.jp/association_basics.html#belongs-to%E3%81%AE%E3%82%AA%E3%83%97%E3%82%B7%E3%83%A7%E3%83%B3-inverse-of
class Member < ApplicationRecord
  belongs_to :division, class_name: "Division", foreign_key: "division_id", optional: true, inverse_of: :members

  validates :member_id, presence: { message: "nilは許可しません" }
  validates :member_id, uniqueness: { message: "重複は許可しません" }
  validates :name, presence: { message: "nilは許可しません" }
end
