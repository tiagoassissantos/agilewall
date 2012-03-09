class Historico < ActiveRecord::Base
  belongs_to :evento
  belongs_to :estoria
  belongs_to :user
end
