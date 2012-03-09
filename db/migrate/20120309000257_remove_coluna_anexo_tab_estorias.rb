class RemoveColunaAnexoTabEstorias < ActiveRecord::Migration
  def self.up
    remove_column :estorias, :anexo
  end

  def self.down
    add_column :estorias, :anexo, :string
  end
end
