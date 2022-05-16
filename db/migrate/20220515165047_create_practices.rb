class CreatePractices < ActiveRecord::Migration[7.0]
  def change
    create_table :practices do |t|
      t.integer :item_id
      t.timestamp :start_time
      t.timestamp :end_time

      t.timestamps

    end
    add_foreign_key :practices, :items
    add_index :practices, :item
  end
end
