class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  embedded_in :topic, counter_cache: :comments_count

  field :user_id, type: BSON::ObjectId
  field :reply_to, type: BSON::ObjectId
  field :content, type: String

  validates :content, presence: true

  def user
    User.find(self.user_id)
  end
  def user=(user)
    self.user_id = user.id
  end
  def parent
    self.topic
  end
  def replies
    parent.comments.where(reply_to: self.id)
  end
end
