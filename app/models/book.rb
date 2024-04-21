class Book < ApplicationRecord
  validates :body, length: { maximum: 200 }
  has_one_attached :image
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true

  def self.search_by_day(date)
    if date.present?
      day_start = date.to_date.beginning_of_day
      day_end = date.to_date.end_of_day
      where(created_at: day_start..day_end)
    else
      all
    end
  end
  
  has_many :book_tags, dependent: :destroy
  has_many :tags, through: :book_tags

  def save_tags(savebook_tags)
    # 現在のユーザーの持っているskillを引っ張ってきている
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 今bookが持っているタグと今回保存されたものの差をすでにあるタグとする。古いタグは消す。
    old_tags = current_tags - savebook_tags
    # 今回保存されたものと現在の差を新しいタグとする。新しいタグは保存
    new_tags = savebook_tags - current_tags
		
    # Destroy old taggings:
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end
		
    # Create new taggings:
    new_tags.each do |new_name|
      book_tag = Tag.find_or_create_by(name:new_name)
      # 配列に保存
      self.tags << book_tag
    end
  end
  
  has_many :comments, dependent: :destroy
  has_many :comment_users, through: :comments, source: :user
end
