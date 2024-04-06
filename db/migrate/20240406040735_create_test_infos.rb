class CreateTestInfos < ActiveRecord::Migration[7.1]
  def change
    create_table :test_infos do |t|
      t.string :test_name, null: false
      t.integer :max_score, null: false

      t.timestamps
    end
  end
end
