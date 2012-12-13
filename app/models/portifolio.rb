class Portifolio < ActiveRecord::Base
  has_many :permissoes
  has_many :projetos
end
