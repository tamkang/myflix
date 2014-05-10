class User < ActiveRecord::Base
  has_many :reviews
  has_secure_password validations: false
  has_many :queue_items, order: :position
  has_many :following_relationships, class_name: "Relationship", foreign_key: :follower_id

  validates :email, uniqueness: true, presence: true
  validates :fullname, presence: true

  before_create :generate_token

  def normalize_position
    queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(position: index+1)
    end
  end

  def follows?(another_user)
    following_relationships.map(&:leader).include?(another_user)
  end

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end
end
