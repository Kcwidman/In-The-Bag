class Disc < ApplicationRecord
  belongs_to :user
  has_many :slots, dependent: :destroy
  has_many :bags, through: :slots
  has_one_attached :picture
end
