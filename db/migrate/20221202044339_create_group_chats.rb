class CreateGroupChats < ActiveRecord::Migration[6.1]
  def change
    create_table :group_chats do |t|

      t.references :user,null: false,foreign_key: true
      t.references :group,null: false,foreign_key: true
      t.text :chat,null: false

      t.timestamps
    end
  end
end
