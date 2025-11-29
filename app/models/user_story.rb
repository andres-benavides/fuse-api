class UserStory < ApplicationRecord
  belongs_to :project
  has_many :tickets, dependent: :destroy

  validates :title, presence: true
end
