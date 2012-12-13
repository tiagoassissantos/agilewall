class AddColunaPortifolioIdEmPermissoes < ActiveRecord::Migration
  def self.up
	  add_column :permissoes, :portifolio_id, :integer
  end

  def self.down
	  remove_column :permissoes, :portifolio_id
  end
end
