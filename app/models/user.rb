class User < ApplicationRecord
  before_create :generate_uuid
  before_save :downcase_email

  has_secure_password
  has_secure_token :authentication_token
  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }
  has_many :todos

  def downcase_email
    self.email = email.downcase
  end

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end

end
