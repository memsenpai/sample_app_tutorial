class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  before_save :email_downcase

  has_secure_password
  validates :name, presence: true, length: {maximum: Settings.name.maximum}
  validates :email, presence: true, length: {maximum: Settings.email.maximum},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password,
    length: {minimum: Settings.password.minimum}
  validates :password_confirmation, presence: true,
    length: {minimum: Settings.password.minimum}, on: [:create]

  private

  def email_downcase
    email.downcase!
  end
end
