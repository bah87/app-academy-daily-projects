# == Schema Information
#
# Table name: albums
#
#  id             :integer          not null, primary key
#  title          :string           not null
#  year           :integer          not null
#  band_id        :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  live_or_studio :string           default("studio"), not null
#

class Album < ApplicationRecord
  validates :title, :year, :band_id, :live_or_studio, presence: true
  validates :live_or_studio, inclusion: ["live", "studio"]
  
  belongs_to :band
  
  has_many :tracks,
  dependent: :destroy
end
