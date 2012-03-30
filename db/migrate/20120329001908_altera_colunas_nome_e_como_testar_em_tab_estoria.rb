class AlteraColunasNomeEComoTestarEmTabEstoria < ActiveRecord::Migration
  def self.up
    rename_column :estorias, :nome, :titulo
    rename_column :estorias, :como_testar, :observacoes
  end

  def self.down
    rename_column :estorias, :titulo, :nome
    rename_column :estorias, :observacoes, :como_testar
  end
end
