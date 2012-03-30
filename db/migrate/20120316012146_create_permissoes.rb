class CreatePermissoes < ActiveRecord::Migration
  def self.up
    create_table :permissoes do |t|
      t.references :user
      t.references :projeto
      t.references :papel

      t.timestamps
    end
  end

  def self.down
    drop_table :permissoes
  end
end
