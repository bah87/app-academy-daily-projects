# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING")
#

class CatRentalRequest < ApplicationRecord
  validates :start_date, :end_date, presence: true
  validates :status, inclusion: {in: ['PENDING', 'APPROVED', 'DENIED']}
  
  belongs_to :cat
  
  def overlapping_requests
    non_overlapping_requests = CatRentalRequest.where("end_date < :start OR start_date > :end", {start: r.start_date, end: r.end_date})
    
    CatRentalRequest.all.select()
  end
end
