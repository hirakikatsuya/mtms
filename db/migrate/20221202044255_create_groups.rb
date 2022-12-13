class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|

      t.string :group_name,null: false
      t.string :group_explain,null: false
      t.integer :owner_id,null: false

      t.timestamps
    end
  end
end
