module Technicians
  class FetchWithEvents
    def self.call(ids)
      technicians = Technician.includes(:events).where(id: ids)

      technicians.map do |t|
        {
          id: t.id,
          name: t.name,
          events: t.events
        }
      end
    end
  end
end
