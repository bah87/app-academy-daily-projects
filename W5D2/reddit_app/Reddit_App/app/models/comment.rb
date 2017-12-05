# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  content           :string           not null
#  author_id         :integer          not null
#  post_id           :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  parent_comment_id :integer
#

class Comment < ApplicationRecord
  validates :post, :content, :author_id, presence: true
  
  belongs_to :post
  
  belongs_to :author,
  foreign_key: :author_id,
  class_name: 'User'
  
  has_many :child_comments,
  class_name: 'Comment',
  foreign_key: :parent_comment_id
  
  belongs_to :parent,
  class_name: 'Comment',
  foreign_key: :parent_comment_id,
  optional: true
  
  has_many :votes, as: :voteable
  
end
