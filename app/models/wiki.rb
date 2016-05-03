class Wiki < ActiveRecord::Base
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators 

  belongs_to :user

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :user, presence: true

  scope :default_order, -> () { order('wikis.created_at DESC') }
end
