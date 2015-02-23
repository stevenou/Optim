class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.joins(:users).where("users.id = ?", user.id)
      end
    end
  end

  def create?
    user.admin? or record.company.users.include?(user)
  end

  def show?
    user.admin? or record.users.include?(user)
  end
end