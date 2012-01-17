class AddColumnTabEstorias < ActiveRecord::Migration
  def self.up
    change_table :estorias do |t|
      t.references :projeto
    end
  end

  def self.down
    remove_column :estorias, :projeto
  end
end
