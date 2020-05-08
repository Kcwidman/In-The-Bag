class Disc < ApplicationRecord
  belongs_to :user
  has_many :bags, through: :slots
end
