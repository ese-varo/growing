class Day < ApplicationRecord
  belongs_to :habit
  has_one :note, as: :noteable, dependent: :destroy
  has_one :checkpoint, dependent: :destroy
  validates :date, presence: true
end
