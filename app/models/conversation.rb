class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy

  scope :between, -> (sender_id, reciever_id) do
    where("(sender_id = ? AND receiver_id = ?) OR (sender_id = ? OR receiver_id = ?)"
    ,[:sender_id], [:receiver_id], [:receiver_id], [:sender_id])
  end

end
