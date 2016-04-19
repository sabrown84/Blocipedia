class WikiPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
  end

  def destroy?
    user.present? && (record.user == user || user.admin?)
  end

  def update?
    user.admin? or not wiki.published?
  end

  class Scope
    attr_reader :user, :scope

    def initializer(user,scope)
      @user = user
      @scope = scope
    end

    def resolve
#      if user.admin?
      scope.all
#    end
    end


   end
end
