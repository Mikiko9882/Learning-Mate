class CreateTestSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :test_settings do |t|
      t.string :test_name
      t.integer :max_score

      t.timestamps
    end
  end
end
