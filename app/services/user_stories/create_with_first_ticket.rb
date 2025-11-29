# frozen_string_literal: true

module UserStories
  class CreateWithFirstTicket

    def self.call(project:, user_story_attrs:, ticket_attrs:, current_user_id:)
      user_story = nil
      ticket     = nil

      ActiveRecord::Base.transaction do
        user_story = project.user_stories.create!(user_story_attrs)

        ticket = user_story.tickets.create!(
          ticket_attrs.merge(
            user_id: current_user_id,
            status: :active
          )
        )
      end

      [true, { user_story: user_story, ticket: ticket }]
    rescue ActiveRecord::RecordInvalid => e
      [false, e.record.errors.full_messages]
    end
  end
end
