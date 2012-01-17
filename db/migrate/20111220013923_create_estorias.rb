class CreateEstorias < ActiveRecord::Migration
  def self.up
    create_table :estorias do |t|
      t.integer :importancia
      t.float :estimativa
      t.integer :status
      t.date :data_conclusao
      t.string :nome
      t.text :descricao
      t.text :como_testar

      t.timestamps
    end
  end

  def self.down
    drop_table :estorias
  end
end
