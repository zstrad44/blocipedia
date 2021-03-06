class WikiPolicy < ApplicationPolicy

  def destroy?
    #@current_user.admin? || @current_user == @wiki.user
    record.user == user || user.admin?

  end

  def edit?
    destroy?
  end

  def update?
    destroy?
  end

  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if @user.nil? || @user.standard?
          scope.where(private: false)
      else
         @scope.all
      end
    end

  end
end
