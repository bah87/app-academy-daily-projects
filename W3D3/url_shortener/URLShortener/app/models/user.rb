class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true

  has_many :submitted_urls,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: 'ShortenedURL'

  has_many :visits,
  primary_key: :id,
  foreign_key: :visitor_id,
  class_name: "Visit"

  has_many :visited_urls,
  through: :visits,
  source: :url_visited

  # has_many :distinct_visited_urls,
  # { distinct },
  # through: :visits,
  # source: :url_visited

end
