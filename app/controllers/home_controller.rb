# encoding: UTF-8
class HomeController < ApplicationController
  def index
  	if user_signed_in? 
  		redirect_to "/inicio"
  	end
  end
end
