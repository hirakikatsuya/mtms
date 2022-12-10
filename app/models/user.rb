class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many:trainings,dependent: :destroy
  has_many:comments,dependent: :destroy
  has_many:favorites,dependent: :destroy

  has_many:group_users, dependent: :destroy
  has_many:groups,through: :group_users, dependent: :destroy
  has_many:group_chats, dependent: :destroy

  has_many:user_rooms,dependent: :destroy
  has_many:messages,dependent: :destroy

  has_many :relationships, class_name:"Relationship", foreign_key:"follower_id", dependent: :destroy
  # relationshipsでRelationテーブルを参照し、follower_idを基準にする
  has_many :followings, through: :relationships, source: :followed
  # followingsでfollower_idにフォローされた人を表示する（フォロー）

  has_many :reverse_relationships, class_name:"Relationship", foreign_key:"followed_id", dependent: :destroy
  # reverse_relationshipsでRelationテーブルを参照し、followed_idを基準にする
  has_many :followers, through: :reverse_relationships, source: :follower
  # followersでfollowed_idがフォローされた人を表示する（フォロワー）

  has_one_attached :profile_image

  validates :name, {presence:true, uniqueness:true, length:{minimum:2, maximum:20}}
  validates :introduction, length:{maximum:50}

  def get_profile_image
    unless profile_image.attached?
      file_path=Rails.root.join("app/assets/images/no_image.jpg")
      profile_image.attach(io:File.open(file_path), filename:"default-image.jpg", content_type:"image/jpeg")
    end
    profile_image.variant(resize_to_limit:[100, 100]).processed
  end

    # フォローするメソッド
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

    # フォローを外すメソッド
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  # フォローしているか確認するメソッド（user_idがfollowingsのrelationshipsテーブルにあるかどうか）
  def following?(user)
    followings.include?(user)
  end

  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  def self.search_for(content, method)
    if method=="perfect"
      User.where(name:content)
    elsif method=="forward"
      User.where("name LIKE?", content+"%")
    elsif method=="backward"
      User.where("name LIKE?", "%"+content)
    else
      User.where("name LIKE?", "%"+content+"%")
    end
  end

end
