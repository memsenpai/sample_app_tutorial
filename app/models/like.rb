class Like < ApplicationRecord
  belongs_to :post, class_name: "Micropost"
  belongs_to :liker, class_name: "User"
  validates :liker_id, presence: true
  validates :post_id, presence: true
end
