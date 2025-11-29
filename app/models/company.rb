# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :projects, dependent: :destroy
  has_many :users, dependent: :destroy

  validates :name, :nit, :email, presence: true
end