class AddColAnexoEstoria < ActiveRecord::Migration
  def self.up
    add_column :estorias, :anexo, :string
  end

  def self.down
    remove_column :estorias, :anexo
  end
end
