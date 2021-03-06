class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  #has_and_belongs_to_many :admin_of,  inverse_of: :admins, class_name: 'Group'
  #has_and_belongs_to_many :member_of, inverse_of: :members, class_name: 'Group'

  has_many :topics
  has_many :wikis
  has_many :resources
  has_many :messages
  has_many :inventories
  has_many :bookings
  has_many :schedules
  has_one :profile

  has_one_attached :avatar

  STATE = {
    inactive: 0,
    normal: 1,
    blocked: 2,
  }

  def self.states
    return STATE
  end

  PERMISSION = {
    none: 0,
    read: 1,
    create: 2,
    update: 3,
    manage: 4,
  }

  def self.permissions
    return PERMISSION
  end

  def normal?
    return self.state == STATE[:normal]
  end

  def superadmin?
    return self.name == 'admin'
  end

  def admin?
    return self.admin || superadmin?
  end

  before_create :ensure_authentication_token
  after_create :create_profile

  validates :name,      presence: true

  def ability
    @ability ||= Ability.new(self)
  end
  delegate :can?, :cannot?, :to => :ability

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  private
  
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
