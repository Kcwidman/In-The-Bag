class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  validates :name, presence: true
  has_many :discs
  has_many :bags
  has_many :offers
  has_many :conversations
  has_many :messages

  has_many :follower_relationships, foreign_key: :following_id, class_name: "Follow"
  has_many :followers, through: :follower_relationships, source: :follower
  has_many :following_relationships, foreign_key: :user_id, class_name: "Follow"
  has_many :followings, through: :following_relationships, source: :following
end
