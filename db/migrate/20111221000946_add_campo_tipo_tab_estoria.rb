class AddCampoTipoTabEstoria < ActiveRecord::Migration
  def self.up
    add_column :estorias, :tipo, :integer
  end

  def self.down
    remove_column :estorias, :tipo
  end
end
