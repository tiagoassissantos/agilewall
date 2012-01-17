class CreateProjetosUsers < ActiveRecord::Migration
  def self.up
    create_table :projetos_users do |t|
      t.references :projeto
      t.references :user
    end
  end

  def self.down
    drop_table :projetos_users
  end
end
