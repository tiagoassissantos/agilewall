# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Evento.create! :id => 1, :nome => 'Estória Criada', :descricao => 'Estória Criada'
Evento.create! :id => 2, :nome => 'Estória Aprovada', :descricao => 'Estória Aprovada'
Evento.create! :id => 3, :nome => 'Estória Retornou ao Backlog', :descricao => 'Estória retornou ao backlog, podendo ser desenvolvida posteriormente'
Evento.create! :id => 4, :nome => 'Início Desenvolvimento', :descricao => 'Início Desenvolvimento'
Evento.create! :id => 5, :nome => 'Desenvolvimento Concluído', :descricao => 'Desenvolvimento Concluído'
Evento.create! :id => 6, :nome => 'Impedimento', :descricao => 'Estória teve um impedimento e está aguardando solução'
Evento.create! :id => 7, :nome => 'Impedimento resolvido', :descricao => 'O Impedimento foi resolvido'
Evento.create! :id => 8, :nome => 'Início Testes', :descricao => 'Início Testes'
Evento.create! :id => 9, :nome => 'Testes Concluídos', :descricao => 'Testes Concluídos'
Evento.create! :id => 10, :nome => 'Entrada em Produção', :descricao => 'Estória foi colocada em Produção'
Evento.create! :id => 11, :nome => 'Estória Descartada', :descricao => 'Estória foi descartada e não será mais desenvolvida'
