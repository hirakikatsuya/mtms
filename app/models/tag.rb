# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :training_tags, dependent: :destroy
  has_many :trainings, through: :training_tags, dependent: :destroy
end
