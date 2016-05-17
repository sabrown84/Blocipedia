class Collaborator < ActiveRecord::Base
  belongs_to :user
  belongs_to :wiki

  validates :wiki_id, uniqueness: { scope: :user_id }
end
