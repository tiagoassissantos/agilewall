class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Projeto do |projeto|
      pode = false
      projeto.permissoes.each do |permissao|
        if permissao.user_id == user.id
          pode = true
          break
        end
      end
      pode
    end
    
    can :administrar, Projeto do |projeto|
      pode = false
      projeto.permissoes.each do |permissao|
        if permissao.user_id == user.id
          if permissao.papel.nome == Papel::GERENTE || permissao.papel.nome == Papel::DONO || permissao.papel.nome == Papel::CLIENTE
            pode = true
            break
          end
        end
      end
      pode
    end
    
    can :desenvolver, Projeto do |projeto|
      pode = false
      projeto.permissoes.each do |permissao|
        if permissao.user_id == user.id
          if permissao.papel.nome == Papel::GERENTE || permissao.papel.nome == Papel::MEMBRO_EQUIPE
            pode = true
            break
          end
        end
      end
      pode
    end
    
    can :testar, Projeto do |projeto|
      pode = false
      projeto.permissoes.each do |permissao|
        if permissao.user_id == user.id
          if permissao.papel.nome == Papel::GERENTE || permissao.papel.nome == Papel::MEMBRO_EQUIPE || permissao.papel.nome == Papel::TESTADOR
            pode = true
            break
          end
        end
      end
      pode
    end
    
    can :commitar, Projeto do |projeto|
      pode = false
      projeto.permissoes.each do |permissao|
        if permissao.user_id == user.id
          if permissao.papel.nome == Papel::GERENTE
            pode = true
            break
          end
        end
      end
      pode
    end
    
    
    can :gerenciar_usuario, Projeto do |projeto|
      pode = false
      projeto.permissoes.each do |permissao|
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
