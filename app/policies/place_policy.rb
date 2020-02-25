# frozen_string_literal: true

class PlacePolicy < ApplicationPolicy
  def create?
    true
  end

  def show?
    true
  end

  def update?
    record.user = user
  end

  def destroy?
    update?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
