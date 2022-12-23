# frozen_string_literal: true

class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  # Userテーブルを参照し、followerを取得する
  belongs_to :followed, class_name: "User"
  # Userテーブルを参照し、followedを取得する
end
