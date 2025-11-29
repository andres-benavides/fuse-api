# frozen_string_literal: true

class Api::V1::TicketsController < ApplicationController
  before_action :set_user_story, only: [:create, :update]
  before_action :set_ticket, only: [:update, :cancel]

def index
    tickets = Tickets::Filter.call(params)

    render json: tickets.as_json(
      include: {
        user_story: {
          include: :project
        }
      }
    )
  end

  def create
    success, ticket = Tickets::Create.call(
      user_story: @user_story,
      attrs: ticket_params,
      current_user_id: current_user_id
    )

    if success
      render json: ticket, status: :created
    else
      render json: { errors: ticket.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    success, ticket = Tickets::Update.call(
      ticket: @ticket,
      attrs: ticket_params
    )

    if success
      render json: ticket
    else
      render json: { errors: ticket.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def cancel
    success, result = Tickets::Cancel.call(@ticket)

    if success
      render json: result
    else
      render json: { error: result }, status: :unprocessable_entity
    end
  end


  private

  def set_user_story
    @user_story = UserStory.find(params[:user_story_id])
  end

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:title, :description, :comments, :status)
  end

  def current_user_id
    params[:user_id] || 1
  end
end
