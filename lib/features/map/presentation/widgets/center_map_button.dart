import 'package:flutter/material.dart';

class CenterMapButton
    extends StatelessWidget {
  // Função utilizada para centralizar mapa
  final VoidCallback onPressed;

  const CenterMapButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 10,

      child: FloatingActionButton(
        heroTag: 'centralizar',

        onPressed: onPressed,

        // Ícone de centralização
        child: const Icon(
          Icons.center_focus_strong,
        ),
      ),
    );
  }
}