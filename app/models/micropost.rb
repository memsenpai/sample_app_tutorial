class Micropost < ApplicationRecord
  belongs_to :user

  has_many :likes, class_name: "Like", foreign_key: "post_id", dependent: :destroy
  has_many :liking, through: :likes, source: :liker

  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.content.maximum}
  validate :picture_size

  scope :active, ->{order created_at: :desc}
  mount_uploader :picture, PictureUploader
  def current_user? current_user
    self.user == current_user
  end
  def like current_user
    liking << current_user
  end

  def unlike current_user
    liking.delete current_user
  end

  def like? current_user
    liking.include? current_user
  end
>>>>>>> like

  private

  def picture_size
<<<<<<< 0d48dd09621e4387b81871e273172161bfa65bb0
    errors.add :picture, t("limit") if picture.size > Settings.limit.megabytes
=======
    errors.add(:picture, t("limit")) if picture.size > 5.megabytes
>>>>>>> like
  end
end
