class Disc < ApplicationRecord
  belongs_to :user
  has_many :offers
  has_many :slots, dependent: :destroy
  has_many :bags, through: :slots
  has_one_attached :picture
  
  COLORS = ["Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink", "White", "Black", "Clear", "Multi-color"].freeze
end
