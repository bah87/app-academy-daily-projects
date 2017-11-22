require 'SecureRandom'

class ShortenedURL < ApplicationRecord
  validates :short_url, uniqueness: true, presence: true
  validates :long_url, presence: true

  belongs_to :submitter,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: 'User'

  has_many :visits,
  primary_key: :id,
  foreign_key: :short_url_id,
  class_name: 'Visit'

  has_many :visitors,
  through: :visits,
  source: :visitor

  # has_many :visitors,
  # { distinct },
  # through: :visits,
  # source: :visitor

  def self.random_code
    while true
      code = SecureRandom.urlsafe_base64
      break unless  ShortenedURL.where(short_url: code).exists?
    end

    code
  end

  def self.create_shortcut(user, long_url)
    ShortenedURL.create!(user_id: user.id, long_url: long_url,
      short_url: ShortenedURL.random_code)
  end

  def find_clicks
    Visit.where(short_url_id: self.id)
  end

  def num_clicks
    self.find_clicks.select(:visitor_id).count
  end

  def num_uniques
    self.find_clicks.select(:visitor_id).distinct.count
  end

  def num_recent_uniques(mins)
    self.find_clicks.where("updated_at > '#{mins}'").select(:visitor_id).distinct.count
  end
end
