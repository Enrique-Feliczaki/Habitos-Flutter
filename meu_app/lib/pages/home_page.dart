import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/habitos_provider.dart';
import 'progresso_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _novoHabito(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Novo hábito'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Ex.: Caminhar 30 min'),
          onSubmitted: (_) {
            context.read<HabitosProvider>().adicionar(controller.text);
            Navigator.pop(ctx);
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              context.read<HabitosProvider>().adicionar(controller.text);
              Navigator.pop(ctx);
            },
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HabitosProvider>();
    final habitos = provider.habitos;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Hábitos'),
        actions: [
          IconButton(
            tooltip: 'Reiniciar o dia',
            icon: const Icon(Icons.refresh),
            onPressed: provider.reiniciarDia,
          ),
          IconButton(
            tooltip: 'Ver progresso',
            icon: const Icon(Icons.bar_chart),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProgressoPage()),
            ),
          ),
        ],
      ),
      body: habitos.isEmpty
          ? const Center(child: Text('Nenhum hábito. Toque em + para criar.'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: habitos.length,
              itemBuilder: (context, i) {
                final h = habitos[i];
                return Card(
                  child: CheckboxListTile(
                    value: h.concluido,
                    onChanged: (_) => provider.alternar(h.id),
                    title: Text(
                      h.nome,
                      style: TextStyle(
                        decoration:
                            h.concluido ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    secondary: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => provider.remover(h.id),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _novoHabito(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}