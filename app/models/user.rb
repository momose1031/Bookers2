class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :follower_relationship, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy #フォロー取得（フォローする側から見て、フォローされる側のユーザーを集める）
  has_many :following_user, through: :follower_relationship, source: :followed #中間テーブルを介して「followed」モデルのユーザー（フォローされた側）を集めることを「following_user」と定義

  has_many :followed_relationship, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy #フォロワー取得（フォローされる側から見て、フォローしてくる側のユーザーを集める）
  has_many :follower_user, through: :followed_relationship, source: :follower #中間テーブルを介して「follower」モデルのユーザー（フォローする側）を集めることを「follower_user」と定義


  attachment :profile_image

  validates :name, uniqueness: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }

  def followed_by?(user)
    # 今自分(引数のuser)がフォローしようとしているユーザー(レシーバー)がフォローされているユーザー(つまりpassive)の中から、引数に渡されたユーザー(自分)がいるかどうかを調べる
    followed_relationship.find_by(follower_id: user.id).present?
  end
  # # ユーザをフォローする
  # def follow(user_id)
  #   follower.create(followed_id: user.id)
  # end
  # # ユーザーのフォローを解除
  # def unfollow(user_id)
  #   follower.find_by(followed_id: user.id).destroy
  # end
  # # フォローしていればtrueを返す
  # def following?(user)
  #   following_user.include?(user)
  # end

  def self.search(search,word)
    if search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "perfect_match"
      @user = User.where(name: word)
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end



end
