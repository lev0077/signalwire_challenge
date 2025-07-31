class CreateTags < ActiveRecord::Migration[8.0]
  def change
    create_table :tags do |t|
      t.string :name, null: false
      t.integer :count, default: 0, null: false

      t.timestamps
    end

    add_index :tags, 'lower(name)', unique: true, name: 'index_tags_on_lower_name'
  end
end
