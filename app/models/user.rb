class User < ApplicationRecord
  validates :name, length: { maximum: 50 }, presence: true
  validates :email, length: { maximum: 50 }, uniqueness: true
  validates :password, length: { minimum: 6 }, presence: true
  before_validation { email.downcase! }
  has_secure_password
  has_many :tasks
  before_destroy :destroy_action
  before_update :update_action

  private

  def destroy_action
    if User.where(admin: true).count == 1 && self.admin
      throw(:abort)
    end
  end

  def update_action
    user = User.where(id: self.id).where(admin: true)
    if User.where(admin: true).count == 1 && user.present? && self.admin == false
      errors.add(:admin, 'から外せません。最低一人の管理者が必要です')
      throw(:abort)
    end
  end
end
