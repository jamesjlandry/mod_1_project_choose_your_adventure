class CreateRoleTable < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.string :name
      t.integer :story_id
    end
  end
end
