class User < ActiveRecord::Base
  has_many :reviews
  has_secure_password validations: false
  has_many :queue_items, order: :position
  has_many :following_relationships, class_name: "Relationship", foreign_key: :follower_id

  validates :email, uniqueness: true, presence: true
  validates :fullname, presence: true


  def normalize_position
    queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(position: index+1)
    end
  end

  def follows?(another_user)
    following_relationships.map(&:leader).include?(another_user)
  end
end
