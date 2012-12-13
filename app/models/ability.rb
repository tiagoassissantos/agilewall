class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Portifolio do |portifolio|
      pode = false
      portifolio.permissoes.each do |permissao|
        if permissao.user_id == user.id
          pode = true
          break
        end
      end
      pode
    end
    
    can :administrar, Portifolio do |portifolio|
      pode = false
      portifolio.permissoes.each do |permissao|
        if permissao.user_id == user.id
          if permissao.papel.nome == Papel::GERENTE || permissao.papel.nome == Papel::DONO || permissao.papel.nome == Papel::CLIENTE
            pode = true
            break
          end
        end
      end
      pode
    end
    
    can :desenvolver, Portifolio do |portifolio|
      pode = false
      portifolio.permissoes.each do |permissao|
        if permissao.user_id == user.id
          if permissao.papel.nome == Papel::GERENTE || permissao.papel.nome == Papel::MEMBRO_EQUIPE
            pode = true
            break
          end
        end
      end
      pode
    end
    
    can :testar, Portifolio do |portifolio|
      pode = false
      portifolio.permissoes.each do |permissao|
        if permissao.user_id == user.id
          if permissao.papel.nome == Papel::GERENTE || permissao.papel.nome == Papel::MEMBRO_EQUIPE || permissao.papel.nome == Papel::TESTADOR
            pode = true
            break
          end
        end
      end
      pode
    end
    
    can :commitar, Portifolio do |portifolio|
      pode = false
      portifolio.permissoes.each do |permissao|
        if permissao.user_id == user.id
          if permissao.papel.nome == Papel::GERENTE
            pode = true
            break
          end
        end
      end
      pode
    end
    
    
    can :gerenciar_usuario, Portifolio do |portifolio|
      pode = false
      portifolio.permissoes.each do |permissao|
        if permissao.user_id == user.id
          if permissao.papel.nome == Papel::GERENTE || permissao.papel.nome == Papel::DONO
            pode = true
            break
          end
        end
      end
      pode
    end
  end
end
