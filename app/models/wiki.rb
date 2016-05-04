class Wiki < ActiveRecord::Base
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators

  belongs_to :user

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :user, presence: true

  scope :default_order, -> () { order('wikis.created_at DESC') }


  def self.visible_to(user) # rubocop:disable Metrics/AbcSize
    wikis = []
    if user
      if user.role == 'admin'
        wikis = Wiki.all
      else
        wikis = Wiki.where('user_id=? OR private=?', user.id, false)
        collaborators = Collaborator.includes(:wiki).where(user_id: user).all
        collaborators.each do |collaborator|
          unless wikis.include?(collaborator.wiki) # rubocop:disable Style/IfUnlessModifier
            wikis.push(collaborator.wiki)
          end
        end
      end
    else
      wikis = Wiki.where(private: false)
    end
    wikis
    # wikis.uniq # uniq method removes private wiki when user is standard
  end
end
