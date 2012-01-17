class AddPapeisToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :papel_id, :integer
  end

  def self.down
    remove_column :users, :papel
  end
end
