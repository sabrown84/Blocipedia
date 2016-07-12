class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    (record.private != true) || (user.role == 'admin') || record.users.include?(user)
  end

  def show?
  end

  def update?
    show?
  end

  def edit?
    show?
  end

  # def destroy?
  # user.present? && (record.user == user || user.admin?)
  # end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve # rubocop:disable MethodLength, AbcSize, CyclomaticComplexity, PerceivedComplexity
      wikis = []
      if user.present? && user.role == 'admin'
        wikis = scope.all
      elsif user.present? && user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.private != true || wiki.user == user || wiki.collaborators.include?(user)
            wikis << wiki
          end
        end
      else
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          wikis << wiki if wiki.private? || wiki.collaborators.include?(user)
        end
      end
      wikis
    end
  end
end
