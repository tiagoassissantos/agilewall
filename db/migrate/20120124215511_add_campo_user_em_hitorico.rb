class AddCampoUserEmHitorico < ActiveRecord::Migration
  def self.up
    add_column :historicos, :user_id, :integer
  end

  def self.down
    remove_column :historicos, :user_id
  end
end
