class CreateContactInfos < ActiveRecord::Migration
  def change
    create_table :contact_infos do |t|
      t.string :nature
      t.string :display_name
      t.string :data
      t.references :client

      t.timestamps
    end
    add_index :contact_infos, :client_id
  end
end
