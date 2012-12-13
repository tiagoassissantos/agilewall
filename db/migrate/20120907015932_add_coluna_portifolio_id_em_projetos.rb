class AddColunaPortifolioIdEmProjetos < ActiveRecord::Migration
  def self.up
	  add_column :projetos, :portifolio_id, :integer
  end

  def self.down
	  remove_column :projetos, :portifolio_id
  end
end
