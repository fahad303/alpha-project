class Article < ActiveRecord::Base
    belongs_to :user
    has_many :article_categories
    has_many :categories, through: :article_categories
    validates :title, presence: true, length: { minimum: 4, maximum: 200}
    validates :description, presence: true, length: {minimum: 10, maximum: 1000}
    validates :user_id, presence: true
end