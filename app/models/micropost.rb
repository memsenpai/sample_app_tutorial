class Micropost < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.content.maximum}
  validate :picture_size

  scope :soft_post, ->{order created_at: :desc}
  scope :find_post_all, ->(user) do
    Micropost.where("user_id IN (:ids)
      OR user_id = :user_id", ids: user.following.ids,
      user_id: user.id).soft_post
  end
  mount_uploader :picture, PictureUploader

  private

  def picture_size
    errors.add :picture, t("limit") if picture.size > Settings.limit.megabytes
  end
end
