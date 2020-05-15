class Disc < ApplicationRecord
  belongs_to :user
  has_many :slots
  has_many :bags, through: :slots
  has_one_attached :picture
end
