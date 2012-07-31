# encoding: UTF-8
class ContatoMailer < ActionMailer::Base
  default :from => "contato@agilewall.com.br"
  
  def mensagem_contato(nome, email, assunto, mensagem)
    @nome = nome
    @email = email
    @assunto = assunto
    @mensagem = mensagem
    
    mail(:to => "contato@agilewall.com.br", :subject => "Contato: " + @assunto) do |format|
      format.html { render 'contato' } #app/view/contact_email.html.erb
    end 
  end
end
