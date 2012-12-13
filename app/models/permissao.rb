class Permissao < ActiveRecord::Base
  belongs_to :user
  #belongs_to :projeto
  belongs_to :portifolio
  belongs_to :papel
end
