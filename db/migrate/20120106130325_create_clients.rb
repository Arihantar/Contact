class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :salutaion
      t.string :name

      t.timestamps
    end
  end
end
