class DropTableAdmin < ActiveRecord::Migration[7.2]
  def up
    drop_table :admins
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
