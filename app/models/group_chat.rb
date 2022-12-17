class GroupChat < ApplicationRecord

  belongs_to:user
  belongs_to:group
  has_one_attached :chat_image
  validates :chat_or_chat_image, presence:true,length:{maximum:100}

  private

  def chat_or_chat_image
    chat.present? || chat_image.present?
  end

end
