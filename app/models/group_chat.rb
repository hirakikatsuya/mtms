class GroupChat < ApplicationRecord
  
  belongs_to:user
  belongs_to:group
  
  validates :chat, {presence:true,length:{maximum:100}}
  
end
