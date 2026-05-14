import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {
  // Obtém a localização atual do usuário
  static Future<LatLng?> getCurrentLocation() async {
    bool serviceEnabled;

    LocationPermission permission;

    // Verifica se o GPS está ativo
    serviceEnabled =
        await Geolocator
            .isLocationServiceEnabled();

    if (!serviceEnabled) {
      return null;
    }

    // Verifica permissões de localização
    permission =
        await Geolocator.checkPermission();

    // Solicita permissão caso necessário
    if (permission ==
        LocationPermission.denied) {
      permission =
          await Geolocator
              .requestPermission();
    }

    // Obtém posição atual do dispositivo
    Position position =
        await Geolocator
            .getCurrentPosition();

    // Retorna latitude e longitude do usuário
    return LatLng(
      position.latitude,
      position.longitude,
    );
  }
}