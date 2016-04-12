class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  #:lockable, :timeoutable and :omniauthable

  has_many :sessions
  has_many :wikis

  after_initialize :set_role

#  before_save {self.role ||= :standard}

  enum role: [:standard, :premium, :admin]


  private

  def set_role
    self.role = "standard"
  end
end
