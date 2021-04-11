class Note < ApplicationRecord
  belongs_to :noteable, polymorphic: true
  validates :description, presence: true
end
