# frozen_string_literal: true

class Training < ApplicationRecord
  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :training_tags, dependent: :destroy
  has_many :tags, through: :training_tags

  validates :start_time, presence: true
  validates :title, { presence: true, length: { maximum: 50 } }
  validates :tags, presence: true
  validates :body, presence: true, length: { maximum: 300 }

  has_one_attached :training_image

  scope :active_users, -> { joins(:user).where(users: { is_deleted: false }) }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def get_training_image
    unless training_image.attached?
      file_path = Rails.root.join("app/assets/images/no_training_image.jpg")
      training_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    training_image.variant(resize_to_limit: [100, 100]).processed
  end

  def self.search_for(content)
      Training.where("title LIKE? OR body LIKE?", "%" + content + "%", "%" + content + "%")
  end
end
