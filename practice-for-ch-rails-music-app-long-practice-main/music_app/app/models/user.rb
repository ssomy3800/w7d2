class User < ApplicationRecord
    validates  :email, :session_token, uniqueness: true
    validates :password, length: { minimum: 6, allow_nil: true }
    validates :password_digest,:session_token,presence: true
  
    attr_reader :password
  
    before_validation :ensure_session_token

  
    has_many :notes, foreign_key: :author_id, dependent: :destroy, inverse_of: :author
  
    def self.find_by_credentials(email, password)
      user = User.find_by(email: email)

      user&.is_password?(password) ? user : nil
    end
  
    def password=(password)
      @password = password
      self.password_digest = BCrypt::Password.create(password)
    end
  
    def is_password?(password)
      BCrypt::Password.new(self.password_digest).is_password?(password)
    end
  
    def reset_session_token!
      self.session_token = generate_unique_session_token
      self.save!
      self.session_token
    end
  

    private
  

  
    def ensure_session_token
      self.session_token ||= generate_unique_session_token
    end