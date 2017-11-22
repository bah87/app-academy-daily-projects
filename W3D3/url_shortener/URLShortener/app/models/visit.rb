class Visit < ApplicationRecord
  validates :visitor_id, presence: true
  validates :short_url_id, presence: true

  belongs_to :visitor,
  primary_key: :id,
  foreign_key: :visitor_id,
  class_name: 'User'

  belongs_to :url_visited,
  primary_key: :id,
  foreign_key: :short_url_id,
  class_name: 'ShortenedURL'

  def self.record_visit!(user, shortened_url)
    Visit.create!(visitor_id: user.id, short_url_id: shortened_url.id)
  end

end
