class Tag < ApplicationRecord

  has_many:training_tags
  has_many:trainings,through: :training_tags

end