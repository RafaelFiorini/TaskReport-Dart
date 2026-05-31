//RF06 – Exibir todas as tarefas convertidas
//RF07 – Filtrar tarefas por status
//RF10 – Calcular total de horas por status
//RF15 – Gerar relatório fi nal

import '../controler/classes/Tarefa.dart';
import '../controler/Controlador.dart';
import '../model/db.dart';

void relatorio() {
  final report = RelatorioTarefas(
    dadosTarefas.map(converteMapParaTarefa).toList(),
  );

  final concluidas = report.tarefas.where((t) => t.status == 'concluida');
  final pendentes = report.tarefas.where((t) => t.status == 'pendente');

  //RF08 – Somar valores das tarefas concluídas
  double valorConcluidas = concluidas.fold(0.0, (soma, t) => soma + t.valor);
  int horasConcluidas = concluidas.fold(0, (soma, t) => soma + t.horas);

  //RF09 – Calcular média de valor das tarefas pendentes
  double valorPendentes = pendentes.fold(0.0, (soma, t) => soma + t.valor);

  Set<String> statusUnicos = report.tarefas.map((t) => t.status).toSet();

  print('RELATÓRIO FINAL DE TAREFAS\n');
  print('Total de tarefas analisadas : ${report.quantidadeTotal}');
  print('Tarefas concluídas: ${concluidas.length}');
  print('tarefas pendentes: ${pendentes.length}');
  print(
    'Tarefas em andamento: ${report.tarefas.where((t) => t.status == 'em andamento').length}',
  );
  print(
    'Tarefas canceladas: ${report.tarefas.where((t) => t.status == 'cancelada').length}\n',
  );

  print(
    'Valor total das concluídas: R\$ ${valorConcluidas.toStringAsFixed(2)}',
  );
  print(
    'Média de valor das pendentes: R\$ ${pendentes.isEmpty ? "0.00" : (valorPendentes / pendentes.length).toStringAsFixed(2)}',
  );
  print('Total de horas concluìdas: $horasConcluidas\n');

  //RF12 – Exibir status únicos usando Set
  print('Status encontrados:');
  statusUnicos.forEach(print);

  //RF11 – Identificar tarefas com dados incompletos
  print('\nTarefas com dados incompletos:');

  dadosTarefas
      .where(
        (item) =>
            item['titulo'] == null ||
            item['responsavel'] == null ||
            item['horas'] == null,
      )
      .forEach(
        (item) => print(
          'ID ${item['id']} - ${item['titulo']?.toString().trim() ?? "Sem título"}',
        ),
      );
}
