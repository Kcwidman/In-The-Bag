class Bag < ApplicationRecord
  # belongs_to :user
  has_many :discs, through: :slots
end
