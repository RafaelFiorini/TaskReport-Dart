import 'ItemTarefa.dart';

class Tarefa extends ItemTarefa {
  String responsavel;
  String status;
  String prioridade;
  double valor;
  int horas;

  Tarefa({
    required int id,
    required String titulo,
    required this.responsavel,
    required this.status,
    required this.prioridade,
    required this.valor,
    required this.horas,
  }) : super(id: id, titulo: titulo);
  @override
  void exibirResumo() {
    print(
      'Tarefa $id - $titulo | Status: $status | Valor: R\$ ${valor.toStringAsFixed(2)}',
    );
  }
}

class RelatorioTarefas {
  final List<Tarefa> _tarefas;

  RelatorioTarefas(this._tarefas);

  List<Tarefa> get tarefas => _tarefas;
  int get quantidadeTotal => _tarefas.length;
}
