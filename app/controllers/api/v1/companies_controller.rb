# frozen_string_literal: true

class Api::V1::CompaniesController < ApplicationController
  def index
    companies = Company.order(:name)
    render json: companies
  end
end