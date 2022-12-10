class Training < ApplicationRecord

  belongs_to:user

  has_many:favorites,dependent: :destroy
  has_many:comments,dependent: :destroy
  has_many:training_tags,dependent: :destroy
  has_many:tags,through: :training_tags

  validates:title, {presence:true,length:{maximum:50}}
  validates:body,presence:true
  validates:training_day,presence:true
  validates:tags,presence: true

  has_one_attached :training_image

  scope :active_users,->{joins(:user).where(users:{is_deleted: false})}

  def favorited_by?(user)
    favorites.exists?(user_id:user.id)
  end

  def get_training_image
    unless training_image.attached?
      file_path=Rails.root.join("app/assets/images/no_image.jpg")
      training_image.attach(io:File.open(file_path), filename:"default-image.jpg", content_type:"image/jpeg")
    end
    training_image.variant(resize_to_limit:[100, 100]).processed
  end

  def self.search_for(content, method)
    if method=="perfect"
      Training.where(title:content)
    elsif method=="forward"
      Training.where("title LIKE?", content+"%")
    elsif method=="backward"
      Training.where("title LIKE?", "%"+content)
    else
      Training.where("title LIKE?", "%"+content+"%")
    end
  end

end
