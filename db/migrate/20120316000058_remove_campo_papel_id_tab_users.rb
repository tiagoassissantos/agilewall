class RemoveCampoPapelIdTabUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :papel_id
  end

  def self.down
    add_column :users, :papel_id, :integer
  end
end
