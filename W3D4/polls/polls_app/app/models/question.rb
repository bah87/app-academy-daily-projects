class Question < ApplicationRecord
  validates :text, presence: true
  validates :poll_id, presence: true
  
  belongs_to :poll,
  primary_key: :id,
  foreign_key: :poll_id,
  class_name: 'Poll'
  
  has_many :answer_choices,
  primary_key: :id,
  foreign_key: :question_id,
  class_name: 'AnswerChoice'
  
  has_many :responses,
  through: :answer_choices,
  source: :responses
  
  def results_n_plus_1
    results = self.answer_choices
    
    response_counts = {}
    results.each do |ans_ch|
      response_counts[ans_ch.text] = ans_ch.responses.count
    end
    
    response_counts
  end
  
  def results
    results = self.answer_choices.includes(:responses)
    
    response_counts = {}
    results.each do |ans_ch|
      response_counts[ans_ch.text] = ans_ch.responses.length
    end
    
    response_counts
  end
  
  def results_sql
    <<-SQL
      SELECT
        answer_choices.*, COUNT(responses.answer_choice_id)
      FROM
        questions
      LEFT OUTER JOIN
        answer_choices ON questions.id = answer_choices.question_id
      LEFT OUTER JOIN
        responses ON responses.answer_choice_id = answer_choices.id
      WHERE
        questions.id = self.id
      GROUP BY
        responses.answer_choice_id
    SQL
  end
  
end