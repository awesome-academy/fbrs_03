class Book < ApplicationRecord
  belongs_to :category
  has_many :marks, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_attached_file :book_img, styles: {book_index: Settings.img.book_index,
                                        book_show: Settings.img.book_show},
    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :book_img, content_type: %r{\Aimage\/.*\z}

  validates :title, presence: true, length: {maximum: Settings.book.title_max},
    uniqueness: {case_sensitive: false}
  validates :author, presence: true, length: {maximum: Settings.book.author_max}

  scope :newest, ->{order created_at: :DESC}
  scope :by_categories,
    ->(category_ids){where category_id: category_ids if category_ids.present?}
  scope :search_by, ->(search_term){
    where "LOWER(title) LIKE :search_term OR LOWER(author) LIKE :search_term",
      search_term: "%#{search_term.downcase}%"}
  scope :by_book_favorite,
    ->(book_ids){where id: book_ids}
end
