class RemoveIdTabelaProjetosUsers < ActiveRecord::Migration
  def self.up
    remove_column :projetos_users, :id
  end

  def self.down
    add_column :projetos_users, :id, :integer
  end
end
