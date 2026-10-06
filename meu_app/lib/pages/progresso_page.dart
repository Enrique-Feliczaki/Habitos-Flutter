import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/habitos_provider.dart';

class ProgressoPage extends StatelessWidget {
  const ProgressoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.watch<HabitosProvider>();
    final percentual = (p.progresso * 100).round();

    return Scaffold(
      appBar: AppBar(title: const Text('Progresso do Dia')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 160,
              height: 160,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(value: p.progresso, strokeWidth: 12),
                  Center(
                    child: Text(
                      '$percentual%',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _Contador(rotulo: 'Total', valor: p.total),
                _Contador(rotulo: 'Concluídos', valor: p.concluidos),
                _Contador(rotulo: 'Pendentes', valor: p.pendentes),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              p.total > 0 && p.pendentes == 0
                  ? 'Parabéns! Você concluiu tudo hoje! 🎉'
                  : 'Continue assim!',
            ),
          ],
        ),
      ),
    );
  }
}

class _Contador extends StatelessWidget {
  final String rotulo;
  final int valor;

  const _Contador({required this.rotulo, required this.valor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$valor', style: Theme.of(context).textTheme.headlineSmall),
        Text(rotulo),
      ],
    );
  }
}