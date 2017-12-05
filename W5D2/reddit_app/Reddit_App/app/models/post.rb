# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  validates :title, :author_id, :subs, presence: true

  belongs_to :author,
  class_name: 'User',
  foreign_key: :author_id
  
  has_many :post_subs,
  dependent: :destroy,
  inverse_of: :post
  
  has_many :subs,
  through: :post_subs,
  source: :sub
  
  has_many :comments
  
  has_many :votes, as: :voteable
  
  def comments_by_parent_id
    comments = Hash.new{ |h,k| h[k] = []}
    self.comments.each do |comment|
      comments[comment.parent_comment_id] << {
        id: comment.id,
        parent_comment_id: comment.parent_comment_id,
        content: comment.content
      }
    end
    comments
  end
end
