class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users, id: :uuid do |t|
      t.string :name
      t.string :email
      t.references :company, null: false, foreign_key: true, type: :uuid
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
