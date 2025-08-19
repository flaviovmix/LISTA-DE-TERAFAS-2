package app.tarefas;

import app.ConexaoPostGres;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TarefaDAO {
    private ConexaoPostGres dataBase;

    public TarefaDAO() {
        dataBase = new ConexaoPostGres();
        dataBase.abrirConexaoJNDI();
    }
    
    public List<TarefaBean> listaTarefasAtivas() {
        return listarTarefasAtivoEInativas(true);
    }    
    public List<TarefaBean> listaTarefasInativas() {
        return listarTarefasAtivoEInativas(false);
    }
    
    private List<TarefaBean> listarTarefasAtivoEInativas(boolean ativoOuInativo) {
    List<TarefaBean> lista = new ArrayList<>();

        StringBuilder sql = new StringBuilder();

        sql.append("SELECT tarefas.* , (");

            sql.append("SELECT COUNT(*) ");

                sql.append("FROM detalhes_tarefa ");
                sql.append("WHERE detalhes_tarefa.fk_tarefa = tarefas.id_tarefa ");

            sql.append(") AS quantidade_de_subtarefas ");

        sql.append("FROM tarefas WHERE ativo = ?;");

        try (PreparedStatement ps = dataBase.getConexao().prepareStatement(sql.toString())) {

            ps.setBoolean(1, ativoOuInativo);

            try (ResultSet resultado = ps.executeQuery()) {

                while (resultado.next()) {

                    TarefaBean tarefa = new TarefaBean();

                    tarefa.setId_tarefa(resultado.getInt("id_tarefa"));
                    tarefa.setTitulo(resultado.getString("titulo"));
                    tarefa.setDescricao(resultado.getString("descricao"));
                    tarefa.setStatus(resultado.getString("status"));
                    tarefa.setPrioridade(resultado.getString("prioridade"));
                    tarefa.setResponsavel(resultado.getString("responsavel"));
                    tarefa.setData_criacao(resultado.getDate("data_criacao"));
                    tarefa.setData_conclusao(resultado.getDate("data_conclusao"));
                    //tarefa.setQuantidade_de_subtarefas(rs.getInt("quantidade_de_subtarefas"));
                    
                    lista.add(tarefa);

                }
            }
        } catch (SQLException erro) {
            erro.printStackTrace();
        }

        return lista;

    }
}
