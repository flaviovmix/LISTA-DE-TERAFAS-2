<%@page import="java.util.List"%>
<%@page import="app.tarefas.TarefaBean"%>
<%@page import="app.tarefas.TarefaDAO"%>
<%
    TarefaDAO tarefaDAO = new TarefaDAO();
    List<TarefaBean> tarefasAtivas = tarefaDAO.listaTarefasAtivas();
    List<TarefaBean> tarefasInativas = tarefaDAO.listaTarefasInativas();
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
<meta charset="UTF-8" />
<title>Tarefas — Ativas e Concluídas</title>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link rel="stylesheet" href="./css/index.css">
</head>
<body>

<header>
  <div class="container">
    <h1>Minhas Tarefas</h1>
    <button class="btn-add">+ Nova Tarefa</button>
  </div>
</header>

<main class="tabs" id="app">
  <!-- radios -->
  <input type="radio" name="tabs" id="tab-ativas" checked>
  <input type="radio" name="tabs" id="tab-concluidas">

  <!-- cabeçalho -->
  <div class="tab-headers">
    <label for="tab-ativas">Ativas</label>
    <label for="tab-concluidas">Concluídas</label>
  </div>

  <!-- painéis -->
  <div class="tab-panels">
      
    <!-- ATIVAS -->
    <section class="tab-panel" id="painel-ativas" aria-labelledby="tab-ativas">
      <% for (TarefaBean tarefa : tarefasAtivas) { %>
      <article class="task media enter" data-id="3">
        <div class="task-content">
          <h3 class="task-title"><%= tarefa.getTitulo() %><a href="#tarefa-3"></a></h3>
          <div class="task-meta">
            <span><i class="fa-solid fa-calendar-days"></i>20/08/2025</span>
            <span><i class='fas fa-user'></i><%= tarefa.getResponsavel() %></span>
            <span class="badge" title="Subtarefas"><i class="fas fa-layer-group"></i><strong>4</strong></span>
          </div>
          <p class="descricao"><%= tarefa.getDescricao() %></p>
        </div>
        <div class="task-actions">
          <label class="checkbox-container" title="Marcar como concluída">
            <input type="checkbox" aria-label="Concluir tarefa">
          </label>
          <button class="btn trash" aria-label="Excluir tarefa">
            <svg class="icon-trash" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M3 6h18M8 6V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6"/>
              <path d="M10 11v6M14 11v6"/>
            </svg>
            Lixeira
          </button>
        </div>
      </article>
      
      <% } %>
        
        
        
    </section>

    <!-- CONCLUÍDAS -->
    <section class="tab-panel" id="painel-concluidas" aria-labelledby="tab-concluidas">
      <% for (TarefaBean tarefa : tarefasInativas) { %>
        <article class="task baixa enter opaco" data-id="4">
        <div class="task-content">
          <h3 class="task-title"><a href="#tarefa-4"><%= tarefa.getTitulo() %></a></h3>
          <div class="task-meta">
            <span><i class="fas fa-calendar-day"></i>10/08/2025</span>
            <span><i class='fas fa-user'></i><%= tarefa.getPrioridade() %></span>
            <span class="badge" title="Subtarefas"><i class="fas fa-layer-group"></i><strong>2</strong></span>
          </div>
          <p class="descricao"><%= tarefa.getDescricao() %></p>
        </div>
        <div class="task-actions">
          <label class="checkbox-container" title="Reabrir tarefa">
            <input type="checkbox" aria-label="Reabrir tarefa" checked>
          </label>
          <button class="btn trash" aria-label="Excluir tarefa">
            <svg class="icon-trash" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M3 6h18M8 6V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6"/>
              <path d="M10 11v6M14 11v6"/>
            </svg>
            Lixeira
          </button>
        </div>
      </article>
      <% } %>
    </section>
    
  </div>
</main>
        <script src="./js/sctipt.js" ></script>
</body>
</html>
