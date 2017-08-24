# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  require 'securerandom'

  attr_reader :password

  validates :username, uniqueness: true, presence: true
  validates :session_token, presence: true
  validates :password_digest, presence: { message: "Password cannot be blank!" }
  validates :password, length: { in: 6..20 }

  before_validation :ensure_session_token


  def find_by_credentials(username, password)
    name = User.find_by(username: username)
    bool_pass = BCrypt::Password.new(name.password_digest).is_password?(password)

    return name if bool_pass
    nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
    # Lazy operator means that we take the existing one (if it's there) or make new.
  end

  def password=(password)
    @password = password # Why? Seems unsecure. Do we actually need to have the variable saved like this?
    self.password_digest = BCrypt::Password.create(password)
  end

end
