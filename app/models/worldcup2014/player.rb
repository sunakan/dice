class Worldcup2014::Player < Worldcup2014::AppRecord
  module Position
    GK = "GK".freeze
    DF = "DF".freeze
    MF = "MF".freeze
    FW = "FW".freeze
    def self.all
      self.constants.map {|position| eval(position.to_s) } # rubocop:disable Security/Eval
    end
  end

  validates :id, presence: true, on: :create
  validates :country_id, presence: true
  validates :country_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :uniform_num, presence: true
  validates :uniform_num, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :position, presence: true
  validates :position, length: { is: 2 }
  validates :position, inclusion: { in: Position.all }
  validates :name, presence: true
  validates :name, length: { in: 1..50 }
  validates :club, presence: true
  validates :club, length: { in: 1..50 }
  validates :birth, presence: true
  validates :height, presence: true
  validates :height, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :weight, presence: true
  validates :weight, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :country
end
