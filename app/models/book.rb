# == Schema Information
#
# Table name: books
#
#  created_at  :datetime         not null
#  description :text
#  id          :bigint           not null, primary key
#  title       :string
#  updated_at  :datetime         not null
#

class Book < ApplicationRecord
  has_one_attached :cover_image
  has_many_attached :sample_images

  validates :title, presence: true
end
