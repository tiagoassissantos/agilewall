class CreateProjetos < ActiveRecord::Migration
  def self.up
    create_table :projetos do |t|
      t.string :nome
      t.string :descricao
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :projetos
  end
end
