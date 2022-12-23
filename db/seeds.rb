# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name:  ENV["NAME_KEY"],
             email: ENV["MAIL_KEY"],
             password:              ENV["PASS_KEY"],
             password_confirmation: ENV["PASS_KEY"],
             is_deleted: false,
             admin: true)

Tag.create!([
              { tag: "胸" },
              { tag: "背中" },
              { tag: "肩" },
              { tag: "腕" },
              { tag: "脚" },
              { tag: "腹筋" },
              { tag: "有酸素" }
              ])
