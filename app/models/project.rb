# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :company
  has_many :user_stories, dependent: :destroy
  has_many :tickets, through: :user_stories

  validates :name, presence: true
end
