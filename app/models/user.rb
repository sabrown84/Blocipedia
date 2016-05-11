class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  #:lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :collaborators
  has_many :collaborations, through: :collaborators, source: :wiki
  has_many :wikis, through: :collaborators

  after_initialize :set_role

#  before_save {self.role ||= :standard}

  enum role: [:standard, :premium, :admin]


  private

  def set_role
    self.role ||= "standard"
  end
end
