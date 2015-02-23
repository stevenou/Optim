class OptimizablePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.joins(:project => :users).where("users.id = ?", user.id)
      end
    end
  end

  def create?
    user.admin? or record.project.users.include?(user)
  end

  def show?
    user.admin? or record.project.users.include?(user)
  end

  def destroy?
    user.admin? or record.project.users.include?(user)
  end
end