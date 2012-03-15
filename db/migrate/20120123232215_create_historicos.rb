class CreateHistoricos < ActiveRecord::Migration
  def self.up
    create_table :historicos do |t|
      t.references :evento
      t.references :estoria
      t.date :data

      t.timestamps
    end
  end

  def self.down
    drop_table :historicos
  end
end
