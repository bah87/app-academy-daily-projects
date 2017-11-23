class Response < ApplicationRecord
  validates :author_id, presence: true
  validates :answer_choice_id, presence: true
  validate :not_duplicate_response
  validate :rigged_response
  
  belongs_to :answer_choice,
  primary_key: :id,
  foreign_key: :answer_choice_id,
  class_name: 'AnswerChoice'
  
  belongs_to :respondent,
  primary_key: :id,
  foreign_key: :author_id,
  class_name: 'User'
  
  has_one :question, 
  through: :answer_choice,
  source: :question
  
  def sibling_responses
    self.question.responses.where.not(id: self.id)
  end
    
  def respondent_already_answered?
    self.sibling_responses.exists?(author_id: self.author_id)
  end
  
  def poll_author_attempted_response?
    self.answer_choice.question.poll.author.id == self.author_id
  end

  private

  def not_duplicate_response
    if respondent_already_answered?
      errors[:duplicate_response] << 'can\'t respond more than once to each question... dum-dumb'
    end
  end
  
  def rigged_response
    if poll_author_attempted_response?
      errors[:rigged_response] << 'drain the swamp!!!'
    end
  end
end