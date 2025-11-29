# app/controllers/api/v1/user_stories_controller.rb
class Api::V1::UserStoriesController < ActionController::API
  before_action :set_project, only: [:index, :create]
  before_action :set_user_story, only: [:show]

  def index
    render json: @project.user_stories, include: :tickets
  end

  def show
    render json: @user_story, include: :tickets
  end

 def create
    success, payload = UserStories::CreateWithFirstTicket.call(
      project: @project,
      user_story_attrs: user_story_params,
      ticket_attrs: ticket_params,
      current_user_id: current_user_id
    )

    if success
      render json: {
        user_story: payload[:user_story],
        first_ticket: payload[:ticket]
      }, status: :created
    else
      render json: { error: payload }, status: :unprocessable_entity
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_user_story
    @user_story = UserStory.find(params[:id])
  end

  def user_story_params
    params.require(:user_story).permit(:title, :description)
  end

  def ticket_params
    params.require(:ticket).permit(:title, :description, :comments)
  end

  def current_user_id
    params[:user_id] || 1
  end
end
