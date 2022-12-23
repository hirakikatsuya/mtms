# frozen_string_literal: true

class TrainingTag < ApplicationRecord
  belongs_to :training
  belongs_to :tag
end
