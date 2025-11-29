class CreateUserStories < ActiveRecord::Migration[7.2]
  def change
    create_table :user_stories, id: :uuid do |t|
      t.string :title
      t.text :description
      t.references :project, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
