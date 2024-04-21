class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
  validates :body, presence: true, length: { maximum: 255 }
end
