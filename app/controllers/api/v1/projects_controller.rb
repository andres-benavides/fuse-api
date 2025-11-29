# frozen_string_literal: true

class Api::V1::ProjectsController < ApplicationController

  def index
    projects = Project.all
    projects = projects.where(company_id: params[:company_id]) if params[:company_id].present?

    render json: projects.order(:name)
  end
end
