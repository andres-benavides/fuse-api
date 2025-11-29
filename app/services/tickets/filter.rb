# frozen_string_literal: true

module Tickets
  class Filter
    def self.call(params)
      scope = Ticket.all

      scope = scope.where(user_id: params[:user_id]) if params[:user_id].present?
      scope = scope.where(status: params[:status]) if params[:status].present?
      if params[:project_id].present?
        scope = scope.joins(user_story: :project)
                     .where(projects: { id: params[:project_id] })
      end

      scope.order(created_at: :desc)
    end
  end
end
