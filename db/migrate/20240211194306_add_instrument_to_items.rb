class AddInstrumentToItems < ActiveRecord::Migration[7.0]
  def change
      add_column :items, :instrument_id, :integer
  end
end
