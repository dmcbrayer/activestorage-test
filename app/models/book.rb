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
  validates :title, presence: true
end
