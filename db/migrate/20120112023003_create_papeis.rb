class CreatePapeis < ActiveRecord::Migration
  def self.up
    create_table :papeis do |t|
      t.string :nome
      t.string :descricao

      t.timestamps
    end
  end

  def self.down
    drop_table :papeis
  end
end
