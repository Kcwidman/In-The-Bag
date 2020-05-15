class Slot < ApplicationRecord
  validates :position, presence: true
  
  belongs_to :bag
  belongs_to :disc
end
