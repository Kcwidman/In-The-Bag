class Slot < ApplicationRecord
  belongs_to :bag
  belongs_to :disc

  acts_as_list scope: :disc
end
