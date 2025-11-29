# frozen_string_literal: true

module Tickets
  class Cancel
    def self.call(ticket)
      unless ticket.active?
        return [false, 'Solo se pueden cancelar tickets activos']
      end

      ticket.canceled!
      [true, ticket]
    end
  end
end
