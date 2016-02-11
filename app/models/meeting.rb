class Meeting
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  field :title,     type: String
  field :content,   type: String
  field :starts_at, type: DateTime, default: -> { DateTime.now }
  field :ends_at,   type: DateTime, default: -> { DateTime.now + 1.hour }
  field :place,     type: String
  field :hidden,    type: Boolean,  default: false

  validates :title, presence: true
  validates :content, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true

  def entity
    Entity.new(self)
  end

  class Entity < Grape::Entity
    expose :id
    expose :title
    expose :content
    expose :starts_at
    expose :ends_at
    expose :place
    expose :created_at
    expose :user_id
  end
end
