class User < ApplicationRecord
  authenticates_with_sorcery!

  belongs_to :grade
  belongs_to :user_class
  has_many :test_results, dependent: :destroy

  has_many :group_users, dependent: :destroy
  has_many :groups, :through => :group_users

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


  enum role: { student: 0, teacher: 1, admin: 2 }

  def average_achievement_rate
    test_results.average(:achievement_rate)
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "crypted_password", "first_name", "grade_id", "id", "id_value", "last_name", "login_id", "nickname", "role", "salt", "updated_at", "user_class_id"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["grade", "test_results", "user_class"]
  end
end
