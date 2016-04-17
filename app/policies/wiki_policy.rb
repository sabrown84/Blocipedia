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

end
