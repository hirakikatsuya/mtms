class CreateTrainingTags < ActiveRecord::Migration[6.1]
  def change
    create_table :training_tags do |t|

      t.references :training,null: false,foreign_key: true
      t.references :tag,null: false,foreign_key: true

      t.timestamps
    end
  end
end
