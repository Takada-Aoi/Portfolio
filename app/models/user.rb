class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name,presence: true
  validates :nickname,presence: true, length: { in: 2..20 }

  has_many :blogs,dependent: :destroy
  has_many :post_comments,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :favorite_blogs, through: :favorites, source: :blog #blogから参照する

 #フォローする側のUserからみたRelationshipをactive_relationship
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
 #followerモデルのフォローされたユーザーを集めることをfollowingsと定義
  has_many :followings, through: :active_relationships, source: :follower

 #フォローされる側のUserからみたRelationshipをpassive_relationship
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
 #followingモデルのフォローする側のユーザーを集めることをfollowersと定義
  has_many :followers, through: :passive_relationships, source: :following

  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end

  attachment :profile_image
  
  def active_for_authentication?
    super && (self.is_deleted == false)
  end

end
