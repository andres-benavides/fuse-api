module Api
  module V1
    class TechnicianController < ActionController::API

      def index
        technicians = Technician.all
        render json: technicians
      end

      def show
        ids = params[:id].to_s.split(',')
        payload = Technicians::FetchWithEvents.call(ids)
        render json: payload
      end

    end
  end
end