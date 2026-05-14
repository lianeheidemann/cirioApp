import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapConstants {
  // 📍 Basílica
  static const LatLng basilica =
      LatLng(-1.452624, -48.476270);

  // 📍 Catedral
  static const LatLng catedral =
      LatLng(-1.456108, -48.504719);

  // 🚶‍♂️ Rota oficial do Círio
  static final List<LatLng> rotaCirio = [
    catedral,
    const LatLng(-1.455800, -48.495000),
    const LatLng(-1.455200, -48.488500),
    const LatLng(-1.454200, -48.482000),
    basilica,
  ];

  // 🌙 Rota da Trasladação
  static final List<LatLng> rotaTranslacao = [
    basilica,
    const LatLng(-1.454200, -48.482000),
    const LatLng(-1.455200, -48.488500),
    const LatLng(-1.455800, -48.495000),
    catedral,
  ];
}