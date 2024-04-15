class GroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :user_id, uniqueness: { scope: :group_id }
  validate :unique_user_ids

  private

  def unique_user_ids
    errors.add(:user_id, 'should be unique') if GroupUser.where(group_id: group_id, user_id: user_id).exists?
  end
end
