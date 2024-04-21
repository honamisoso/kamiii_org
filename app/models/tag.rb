class Tag < ApplicationRecord

 has_many :book_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :books, through: :book_tags
  
  
  scope :merge_books, -> (tags){ }
  
  def self.search_books_for(content, method)
    
    tags = Tag.where('name LIKE ?', '%' + content + '%')
    
    tags.inject(init = []) {|result, tag| result + tag.books}
    
  end
  

end
