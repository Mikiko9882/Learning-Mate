class User < ApplicationRecord
  authenticates_with_sorcery!

  belongs_to :grade
  belongs_to :user_class

  validates :login_id, uniqueness: true, presence: true
  validate :login_id_format

  def login_id_format
    unless login_id.match?(/\A(?=.*[0-9])(?=.*[a-zA-Z])[0-9a-zA-Z]+\z/)
      errors.add(:login_id, "は数字とアルファベットの両方を含む必要があります")
    end
  end

  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :nickname, presence: true

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

end