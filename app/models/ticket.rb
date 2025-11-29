# frozen_string_literal: true

class Ticket < ApplicationRecord
  belongs_to :user_story
  belongs_to :user

  enum status: {
    active: 0,
    in_process: 1,
    finished: 2,
    canceled: 3
  }

  validates :title, :status, presence: true
end
