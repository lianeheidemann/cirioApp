import 'package:flutter/material.dart';

class MapToggleButton
    extends StatelessWidget {
  // Identifica qual evento está ativo
  final bool isCirio;

  // Função executada ao clicar no botão
  final VoidCallback onPressed;

  const MapToggleButton({
    super.key,
    required this.isCirio,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      right: 10,

      child: ElevatedButton(
        onPressed: onPressed,

        // Alterna entre Círio e Trasladação
        child: Text(
          isCirio
              ? 'Ver Trasladação'
              : 'Ver Círio',
        ),
      ),
    );
  }
}