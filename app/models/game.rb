class Game < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :competitions, class_name: "Stats::Competition", dependent: :restrict_with_error
end
