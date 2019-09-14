class User < ApplicationRecord
  has_many :appointments
  has_many :corporations, :through => :corporation_users
  has_many :contracts
  has_many :projects
  has_and_belongs_to_many :projects
  
  devise :invitable, :database_authenticatable, :registerable, :invitable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.current=(user)
    Thread.current[:current_user] = user
  end

  def self.current
    Thread.current[:current_user]
  end

end
