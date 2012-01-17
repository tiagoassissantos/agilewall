class RemoveColunaUserTabProjetos < ActiveRecord::Migration
  def self.up
    remove_column :projetos, :user_id
  end

  def self.down
    add_column :projetos, :user_id, :integer
  end
end
