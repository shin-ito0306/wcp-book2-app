class Book < ApplicationRecord

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
  
  is_impressionable counter_cache: true

  def self.looks(matches, words)
    if matches == "perfect_match"
      @book = Book.where("title LIKE ?", "#{words}")
    elsif matches == "left_match"
      @book = Book.where("title LIKE ?", "#{words}%")
    elsif matches == "right_match"
      @book = Book.where("title LIKE ?", "%#{words}")
    else
      @book = Book.where("title LIKE ?", "%#{words}%")
    end
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def week_time
    
    Favorite.where(created_at: from...to).count
  end
end
