# encoding: utf-8
class Estoria < ActiveRecord::Base 
  belongs_to :projeto
  has_many :anexos, :dependent => :destroy
end
