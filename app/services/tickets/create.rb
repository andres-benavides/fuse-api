# frozen_string_literal: true

module Tickets
  class Create
    def self.call(user_story:, attrs:, current_user_id:)
      ticket = user_story.tickets.new(attrs)
      ticket.user_id = current_user_id
      ticket.status ||= :active

      [ticket.save, ticket]
    end
  end
end