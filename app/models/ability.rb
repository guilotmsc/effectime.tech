# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    can :read, Corporation, public: true
    can :read, Client, public: true
    can :read, Project, public: true
    can :read, Contract, public: true

    if user.present?  # additional permissions for logged in users (they can read their own posts)
      can [:update, :destroy], Corporation.all.joins(:corporation_users).where("corporation_users.user_id = #{user.id}")
      can [:update, :destroy], Client.find_by_sql("SELECT clients.*
                                  FROM clients
                                  INNER JOIN corporation_users ON corporation_users.corporation_id = clients.corporation_id 
                                  WHERE corporation_users.user_id = #{user.id}")
      can [:update, :destroy], Project.joins("left outer join clients on clients.id = projects.client_id")
                               .where("(projects.corporation_id in (
                                      select corporation_id from corporation_users where user_id = #{user.id})
                                      or
                                      clients.corporation_id in (
                                      select corporation_id from corporation_users where user_id = #{user.id}))")
      can [:update, :destroy], Contract.joins("inner join clients on clients.id = contracts.client_id").where("clients.corporation_id in (select corporation_id from corporation_users where user_id = #{user.id})")
      
    end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
