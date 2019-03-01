class Worldcup2014::Country < Worldcup2014::AppRecord
  module Group
    A = "A".freeze
    B = "B".freeze
    C = "C".freeze
    D = "D".freeze
    E = "E".freeze
    F = "F".freeze
    G = "G".freeze
    H = "H".freeze
    def self.all
      self.constants.map {|group| eval(group.to_s) } # rubocop:disable Security/Eval
    end
  end

  validates :id, presence: true, on: :update
  validates :id, uniqueness: true, on: :update
  validates :name, presence: true
  validates :name, length: { in: 1..50 }
  validates :ranking, presence: true
  validates :ranking, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :group_name, presence: true
  validates :group_name, length: { is: 1 }
  validates :group_name, inclusion: { in: Group.all }

  has_many :players, dependent: :destroy
end
