# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Evento.create! :id => 1, :nome => 'Criada', :descricao => 'Estória foi criada'
Evento.create! :id => 2, :nome => 'Aprovada', :descricao => 'Estória está agora com status Aprovada'
Evento.create! :id => 3, :nome => 'Aguardando Desenvolvimento', :descricao => 'Estória está agora com status Em Desenvolvimento'
Evento.create! :id => 4, :nome => 'Em Desenvolvimento', :descricao => 'Estória está agora com status Em Desenvolvimento'
Evento.create! :id => 5, :nome => 'Desenvolvimento Concluído', :descricao => 'Estória está agora com status Desenvolvimento Concluído'
Evento.create! :id => 6, :nome => 'Impedimento', :descricao => 'Estória está agora com status Em Impedimento, e está aguardando solução'
Evento.create! :id => 7, :nome => 'Em Testes', :descricao => 'Estória está agora com status Em Testes'
Evento.create! :id => 8, :nome => 'Testes Concluídos', :descricao => 'Estória está agora com status Testes Concluídos'
Evento.create! :id => 9, :nome => 'Entrada em Produção', :descricao => 'Estória foi colocada em Produção'

Evento.create! :id => 10, :nome => 'Estória Excluída', :descricao => 'Estória foi excluída e não será mais desenvolvida'
Evento.create! :id => 11, :nome => 'Impedimento resolvido', :descricao => 'O Impedimento foi resolvido'
