import 'classes/Tarefa.dart';

double converteValor(dynamic v) => v == null
    ? 0.0
    : (double.tryParse(
            v
                .toString()
                .replaceAll('R\$', '')
                .replaceAll(' ', '')
                .replaceAll(',', '.'),
          ) ??
          0.0);
int converteHoras(dynamic h) =>
    h == null ? 0 : (int.tryParse(h.toString()) ?? 0);

Tarefa converteMapParaTarefa(Map<String, dynamic> item) => Tarefa(
  id: item['id'] ?? 0,
  titulo: item['titulo']?.toString().trim() ?? 'Sem título',
  responsavel: item['responsavel']?.toString().trim() ?? 'Não informado',
  status: item['status']?.toString().trim() ?? 'sem status',
  prioridade: item['prioridade']?.toString().trim() ?? 'sem prioridade',
  valor: converteValor(item['valor']),
  horas: converteHoras(item['horas']),
);

