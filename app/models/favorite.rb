class Favorite < ApplicationRecord
  
  validates_uniqueness_of :book_id, scope: :user_id
  belongs_to :user
  belongs_to :book
end
