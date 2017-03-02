class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :members
      t.string :info
      t.string :owner

      t.timestamps null: false
    end
  end
end
