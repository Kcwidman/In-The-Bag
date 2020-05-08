class Bag < ApplicationRecord
  validates :capacity, presence: true

  belongs_to :user
  has_many :slots
  has_many :discs, through: :slots
  accepts_nested_attributes_for :slots, reject_if: proc { |attributes| attributes['disc_id'].blank? }
end
