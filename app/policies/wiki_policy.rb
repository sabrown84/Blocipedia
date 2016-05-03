class WikiPolicy < ApplicationPolicy


  def index?
    true
  end

  def show?
    record.private != true || (user.present? && ((user.role == 'admin') || record.user == user || record.users.include?(user)))
  end

  def update?
    show?
  end

  def edit?
    show?
  end

  #def destroy?
    #user.present? && (record.user == user || user.admin?)
    #end

class Scope
  attr_reader :user, :scope

  def initialize(user, scope)
    @user = user
    @scope = scope
  end

  def resolve
    wikis = []
    if user.present? && user.role == 'admin'
      wikis = scope.all
    elsif user.present? && user.role == 'premium_user'
      all_wikis = scope.all
      all_wikis.each do |wiki|
        if wiki.public? || wiki.owner == user || wiki.collaborators.include?(user)
          wikis << wiki
        end
      end
    else
      all_wikis = scope.all
      wikis = []
      all_wikis.each do |wiki|
        if wiki.public? || wiki.collaborators.include?(user)
          wikis << wiki
        end
      end
    end
    wikis
  end
end
end
