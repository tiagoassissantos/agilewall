class Historico < ActiveRecord::Base
  belongs_to :evento
  belongs_to :estoria
end
