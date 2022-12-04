class Training < ApplicationRecord

  belongs_to:user

  has_many:training_tags
  has_many:tags,through: :training_tags

  validates:title, {presence:true,length:{maximum:50}}
  validates:body,presence:true

  has_one_attached :training_image

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


end
