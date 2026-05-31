import '../controler/classes/Tarefa.dart';
import '../controler/Controlador.dart';
import '../model/db.dart';

void relatorio (){
  final report = RelatorioTarefas(
  dadosTarefas.map(converteMapParaTarefa).toList());
  
  final concluidas = report.tarefas.where((t) => t.status == 'concluida');
  final pendentes = report.tarefas.where((t) => t.status == 'pendente');

  double valorConcluidas = concluidas.fold(0.0, (soma, t) => soma + t.valor);
  int horasConcluidas = concluidas.fold(0, (soma, t) => soma + t.horas);
  double valorPendentes = pendentes.fold(0.0, (soma, t) => soma + t.valor);

  Set<String> statusUnicos = report.tarefas.map((t) => t.status).toSet();

  print('RELATÓRIO FINAL DE TAREFAS\n');
  print('Total de tarefas analisadas : ${report.quantidadeTotal}');
  print('Tarefas concluídas: ${concluidas.length}');
  print('tarefas pendentes: ${pendentes.length}');
  print('Tarefas em andamento: ${report.tarefas.where((t) => t.status == 'em andamento').length}');
  print('Tarefas canceladas: ${report.tarefas.where((t) => t.status == 'cancelada').length}\n');

  print('Valor total das concluídas: R\$ ${valorConcluidas.toStringAsFixed(2)}');
  print('Média de valor das pendentes: R\$ ${pendentes.isEmpty ? "0.00" 
  : (valorPendentes / pendentes.length).toStringAsFixed(2)}');
  print('Total de horas concluìdas: $horasConcluidas\n');

  print('Status encontrados:');
  statusUnicos.forEach(print);

  print('\nTarefas com dados incompletos:');

  dadosTarefas
  .where((item) => item['titulo'] == null || item['responsavel'] == null || item['horas'] == null)
  .forEach((item) => print('ID ${item['id']} - ${item['titulo']?.toString().trim()?? "Sem título"}'));
}