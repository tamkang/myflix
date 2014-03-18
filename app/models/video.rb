class Video < ActiveRecord::Base
  has_many :reviews, order: "created_at DESC"
  has_many :queue_items
  belongs_to :category

  validates :title, presence: true
  validates :description, presence: true

  def self.search_by_title(search_term)
    where("title LIKE ?", "%#{search_term}%").order("created_at DESC")
  end
end
