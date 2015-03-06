class Topic
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  belongs_to :user
  embeds_many :comments

  field :title, type: String
  field :content, type: String
  field :category, type: String
  field :tags, type: Array
  field :comments_count, type: Integer
  field :hits, type: Integer, default: 0
  field :public, type: Boolean, default: false
  
  validates :title, presence: true
  validates :content, length: { minimum: 50 }
end
