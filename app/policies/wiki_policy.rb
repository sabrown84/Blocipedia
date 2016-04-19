class WikiPolicy < Application Policy

  def index?
    true
  end

  def show?
  end

  class Scope < Scope
    attr_reader :user, :scope

    def initializer(user,scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin?
      scope.all
    end
  end

  def update?
    user.admin? or not wiki.published?
  end
end
end
