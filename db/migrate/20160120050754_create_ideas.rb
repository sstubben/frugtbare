class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :description
      t.integer :level_of_fun
      t.integer :level_of_complexity

      t.timestamps
    end
  end
end
