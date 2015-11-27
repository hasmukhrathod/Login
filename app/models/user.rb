class User < ActiveRecord::Base
  
  validates :first_name, :last_name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create },length: { maximum: 255 }
  validates :password, presence: true
  
  #To persist one in memory long enough to generate a password hash, we need to allow password as an attribute on User, even if only temporarily.
  attr_accessor :password, :reset_token
  #another virtual attribute that doesn't exist in database.
  validates_confirmation_of :password
  #This all should happen before the User record is saved
  before_save :encrypt_password
  def encrypt_password
    self.password_salt = BCrypt::Engine.generate_salt #A random password salt is generated for this specific user and stored on this specific user
    self.password_hash = BCrypt::Engine.hash_secret(password, password_salt) #The password salt and supplied password for this user are hashed together into a password hash, which is also stored on this specific user.
    
  end
  
  def self.authenticate(email,password)
    user = User.where(email: email).first
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  def current_user?(user)
    user == current_user
  end
  
   # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = BCrypt::Engine.generate_salt
    update_attribute(:reset_digest,  reset_token)
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  
  
end
