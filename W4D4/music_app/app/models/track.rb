# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  ord        :integer          not null
#  lyrics     :string
#  album_id   :integer          not null
#  track_type :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Track < ApplicationRecord
  validates :title, :ord, :album_id, :track_type, presence: true
  validates :track_type, inclusion: ["regular", "bonus"]
  
  belongs_to :album
end
