class WikiPolicy < ApplicationPolicy

  def destroy?
    #@current_user.admin? || @current_user == @wiki.user
     record.user == user || user.admin? || record.users.include?(@current_user)
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
    wikis = []
    if user.role == 'admin'
     wikis = scope.all # if the user is an admin, show them all the wikis
    elsif user.role == 'premium'
     all_wikis = scope.all
     all_wikis.each do |wiki|
       if wiki.public? || wiki.user == user || wiki.users.include?(user)
         wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
       end
     end
    else # this is the lowly standard user
     all_wikis = scope.all
     wikis = []
     all_wikis.each do |wiki|
       if wiki.public? || wiki.users.include?(user)
         wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
       end
     end
    end
    wikis # return the wikis array we've built up
   end
  end


  # class Scope < Scope
  #   attr_reader :user, :scope
  #
  #   def initialize(user, scope)
  #     @user = user
  #     @scope = scope
  #   end
  #
  #   def resolve
  #     if @user.nil? || @user.standard?
  #         scope.where(private: false)
  #     else
  #        @scope.all
  #     end
  #   end
  #
  # end
end
