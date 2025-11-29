# frozen_string_literal: true

module Tickets
  class Update
    def self.call(ticket:, attrs:)
      [ticket.update(attrs), ticket]
    end
  end
end