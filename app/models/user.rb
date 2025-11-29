# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :company

  has_secure_password

  validates :name, :email, presence: true
  validates :email, uniqueness: true
end
