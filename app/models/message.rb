class Message < ApplicationRecord

  belongs_to :user
  belongs_to :room
  has_one_attached :message_image
  validates :message_or_message_image,presence:true,length:{maximum:100}

  private

  def message_or_message_image
    message.present? || message_image.present?
  end

end
