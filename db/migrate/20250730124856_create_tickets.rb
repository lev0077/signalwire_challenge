class CreateTickets < ActiveRecord::Migration[8.0]
  def change
    create_table :tickets do |t|
      t.integer :user_id
      t.string :title
      t.datetime :received_at

      t.timestamps
    end
  end
end
