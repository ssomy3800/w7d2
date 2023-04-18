class User < ApplicationRecord
    validates :activation_token, :email, :session_token, uniqueness: true
    validates :password, length: { minimum: 6, allow_nil: true }
    # can't use presence validation with boolean field
    validates :password_digest,:session_token,:activation_token,presence: true
  
    attr_reader :password
  
    before_validation :ensure_session_token
    after_initialize :set_activation_token, :set_defaults
  
    has_many :notes, foreign_key: :author_id, dependent: :destroy, inverse_of: :author
  
    def self.find_by_credentials(email, password)
      user = User.find_by(email: email)
      # `user&.is_password?(password)` is syntactic sugar for
      # `user && user.is_password?(password)`
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
  
    def generate_unique_session_token
      # `SecureRandom::urlsafe_base64` does not guarantee uniqueness. Wrapping
      # this call in a loop ensures that no other user has the generated token.
      loop do
        session_token = SecureRandom::urlsafe_base64(16)
        return session_token unless User.exists?(session_token: session_token)
      end
    end
  
    def ensure_session_token
      self.session_token ||= generate_unique_session_token
    end