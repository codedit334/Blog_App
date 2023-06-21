class Ability
    include CanCan::Ability
  
    def initialize(user)
    #   user ||= User.new
      user ||= current_user
      if user.role == 'admin'
        can :manage, :all
      else
        can :read, :all
        can :create, [Post, Comment]
        can :update, [Post, Comment], author: user.id
        can :destroy, Post, author: user.id
        can :destroy, Comment, author: user.id
      end
    end
  end
  