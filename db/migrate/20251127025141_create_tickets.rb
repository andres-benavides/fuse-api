class CreateTickets < ActiveRecord::Migration[7.2]
  def change
    create_table :tickets, id: :uuid do |t|
      t.string :title
      t.text :description
      t.text :comments
      t.integer :status
      t.references :user_story, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
