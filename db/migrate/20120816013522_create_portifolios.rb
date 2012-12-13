class CreatePortifolios < ActiveRecord::Migration
  def self.up
    create_table :portifolios do |t|
      t.string :nome
      t.string :descricao

      t.timestamps
    end
  end

  def self.down
    drop_table :portifolios
  end
end
