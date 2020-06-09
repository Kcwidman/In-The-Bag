class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  belongs_to :receiver, class_name: "User"
  belongs_to :sender, class_name: "User"

  # between always returns at most, 1 conversation object. Use .first after the method to retrieve the query
  # as an object as opposed to an array of size 1.
  scope :between, ->(sender_id, receiver_id) {
                    where("(conversations.sender_id = ? AND conversations.receiver_id = ?) OR
    (conversations.sender_id = ? AND conversations.receiver_id = ?)",
                      sender_id, receiver_id, receiver_id, sender_id)
                  }

  # returns the name of the chat partner
  def other_party_name(current_user_id)
    return receiver.name if current_user_id == sender_id
    sender.name
  end
end
