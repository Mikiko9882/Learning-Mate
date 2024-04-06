class AddGradeAndClassToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :grade, foreign_key: true
    add_reference :users, :user_class, foreign_key: true
  end
end
