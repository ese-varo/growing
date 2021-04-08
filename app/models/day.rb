class Day < ApplicationRecord
  belongs_to :habit
  has_one :note, as: :noteable
end
