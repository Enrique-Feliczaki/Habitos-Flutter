import 'package:flutter/foundation.dart';

class Habito {
  final String id;
  final String nome;
  bool concluido;

  Habito({required this.id, required this.nome, this.concluido = false});
}

class HabitosProvider extends ChangeNotifier {
  final List<Habito> _habitos = [
    Habito(id: '1', nome: 'Beber 2L de água'),
    Habito(id: '2', nome: 'Estudar Flutter'),
  ];

  List<Habito> get habitos => List.unmodifiable(_habitos);

  int get total => _habitos.length;

  int get concluidos => _habitos.where((h) => h.concluido).length;

  int get pendentes => total - concluidos;

  double get progresso => total == 0 ? 0 : concluidos / total;

  void adicionar(String nome) {
    if (nome.trim().isEmpty) return;
    _habitos.add(Habito(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      nome: nome.trim(),
    ));
    notifyListeners();
  }

  void alternar(String id) {
    final habito = _habitos.firstWhere((h) => h.id == id);
    habito.concluido = !habito.concluido;
    notifyListeners();
  }

  void remover(String id) {
    _habitos.removeWhere((h) => h.id == id);
    notifyListeners();
  }

  void reiniciarDia() {
    for (final h in _habitos) {
      h.concluido = false;
    }
    notifyListeners();
  }
}