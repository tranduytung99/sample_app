class User < ApplicationRecord
  before_save :email_down
  validates :name, presence: true, length: {maximum: Settings.user_valide.name}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings.user_valide.email},
    format: {with: VALID_EMAIL_REGEX}
  validates :password, presence: true, length: {minimum: Settings.user_valide.pass}
  has_secure_password

  def email_down
    self.email.downcase!
  end
end
