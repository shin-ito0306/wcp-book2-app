class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :follower_do, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :follower_user, through: :follower_do, source: :followed

  has_many :followed_do, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followed_user, through: :followed_do, source: :follower

  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  attachment :profile_image

  validates :name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: { maximum: 50 }

  def self.looks(matches, words)
    if matches == "perfect_match"
      @user = User.where("name LIKE ?", "#{words}")
    elsif matches == "left_match"
      @user = User.where("name LIKE ?", "#{words}%")
    elsif matches == "right_match"
      @user = User.where("name LIKE ?", "%#{words}")
    else
      @user = User.where("name LIKE ?", "%#{words}%")
    end
  end

  def follow_by?(user)
    followed_do.find_by(follower_id: user.id).present?
  end



end
