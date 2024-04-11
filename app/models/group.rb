class Group < ApplicationRecord
  
  has_many :group_users, dependent: :destroy
  belongs_to :owner, class_name: 'User'
  has_many :users, through: :group_users

  validates :group_name, presence: true

  def is_owned_by?(user)
    owner.id == user.id
  end
end
