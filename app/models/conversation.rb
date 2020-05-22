class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy

  scope :between, -> (sender_id, reciever_id) do
    where("(conversations.sender_id = ? AND conversations.receiver_id = ?) OR 
    (conversations.sender_id = ? OR conversations.receiver_id = ?)"
    ,sender_id, receiver_id, receiver_id, sender_id)
  end

end
