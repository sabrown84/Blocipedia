class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  #:lockable, :timeoutable and :omniauthable

  has_many :sessions
  has_many :wikis

  after_initialize :set_role

  enum role: [:standard, :premium, :admin]


  def self.authenitcate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
