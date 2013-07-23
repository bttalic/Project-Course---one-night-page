class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :listener_id
      t.integer :listened_id

      t.timestamps
    end

    add_index :relationships, :listener_id
    add_index :relationships, :listened_id
    add_index :relationships, [:listener_id, :listened_id], unique: true
  end
end