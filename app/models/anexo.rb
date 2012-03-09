class Anexo < ActiveRecord::Base
  require "carrierwave"
  belongs_to :estoria
  mount_uploader :arquivo, ArquivoUploader
end
