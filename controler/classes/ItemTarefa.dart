class ItemTarefa {
  int id;
  String titulo;

  ItemTarefa({required this.id, required this.titulo});
  void exibirResumo() => print('Item $id - $titulo');
}
