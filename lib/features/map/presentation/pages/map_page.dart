import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/constants/map_constants.dart';

import '../../models/evento_cirio.dart';

import '../../services/location_service.dart';

import '../widgets/map_toggle_button.dart';

import '../widgets/center_map_button.dart';

// Página principal responsável pelo mapa
class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() =>
      _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // Controlador do Google Maps
  GoogleMapController? _mapController;

  // Evento atualmente exibido
  EventoCirio _eventoAtual =
      EventoCirio.cirio;

  // Localização atual do usuário
  LatLng? _userLocation;

  // Marcadores exibidos no mapa
  final Set<Marker> _markers = {};

  // Rotas exibidas no mapa
  final Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();

    // Carrega marcadores e rotas iniciais
    _atualizarMapa();

    // Obtém localização do usuário
    _obterLocalizacao();
  }

  // Obtém coordenadas atuais do dispositivo
  Future<void> _obterLocalizacao() async {
    _userLocation =
        await LocationService
            .getCurrentLocation();

    // Cria rota do usuário até o evento
    _criarLinhaUsuario();

    setState(() {});
  }

  // Desenha rota do usuário até o início do evento
  void _criarLinhaUsuario() {
    if (_userLocation == null) {
      return;
    }

    // Define destino conforme evento selecionado
    final destino =
        _eventoAtual == EventoCirio.cirio
            ? MapConstants.catedral
            : MapConstants.basilica;

    // Remove rota antiga do usuário
    _polylines.removeWhere(
      (polyline) =>
          polyline.polylineId.value ==
          'rota_usuario',
    );

    // Desenha nova rota do usuário
    _polylines.add(
      Polyline(
        polylineId:
            const PolylineId(
              'rota_usuario',
            ),

        points: [
          _userLocation!,
          destino,
        ],

        color: Colors.red,

        width: 6,
      ),
    );
  }

  // Atualiza marcadores e trajetos exibidos
  void _atualizarMapa() {
    final isCirio =
        _eventoAtual ==
        EventoCirio.cirio;

    // Seleciona trajeto correspondente
    final rota =
        isCirio
            ? MapConstants.rotaCirio
            : MapConstants
                .rotaTranslacao;

    _markers.clear();
    _polylines.clear();

    // Marcador do início do evento
    _markers.add(
      Marker(
        markerId: const MarkerId(
          'inicio',
        ),

        position: rota.first,

        icon:
            BitmapDescriptor
                .defaultMarkerWithHue(
                  BitmapDescriptor
                      .hueRed,
                ),
      ),
    );

    // Marcador do final do evento
    _markers.add(
      Marker(
        markerId: const MarkerId(
          'fim',
        ),

        position: rota.last,

        icon:
            BitmapDescriptor
                .defaultMarkerWithHue(
                  BitmapDescriptor
                      .hueBlue,
                ),
      ),
    );

    // Desenha trajeto oficial do evento
    _polylines.add(
      Polyline(
        polylineId:
            const PolylineId(
              'rota_oficial',
            ),

        points: rota,

        color:
            isCirio
                ? Colors.blue
                : Colors.orange,

        width: 5,
      ),
    );

    // Atualiza rota do usuário
    _criarLinhaUsuario();

    setState(() {});
  }

  // Centraliza câmera considerando rotas e usuário
  void _centralizarMapa() {
    final rota =
        _eventoAtual == EventoCirio.cirio
            ? MapConstants.rotaCirio
            : MapConstants
                .rotaTranslacao;

    List<LatLng> pontos = [...rota];

    // Inclui usuário na área visível do mapa
    if (_userLocation != null) {
      pontos.add(_userLocation!);
    }

    // Calcula limites do mapa
    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(
        pontos
            .map(
              (e) => e.latitude,
            )
            .reduce(
              (a, b) =>
                  a < b ? a : b,
            ),

        pontos
            .map(
              (e) => e.longitude,
            )
            .reduce(
              (a, b) =>
                  a < b ? a : b,
            ),
      ),

      northeast: LatLng(
        pontos
            .map(
              (e) => e.latitude,
            )
            .reduce(
              (a, b) =>
                  a > b ? a : b,
            ),

        pontos
            .map(
              (e) => e.longitude,
            )
            .reduce(
              (a, b) =>
                  a > b ? a : b,
            ),
      ),
    );

    // Move câmera para os limites calculados
    _mapController?.animateCamera(
      CameraUpdate.newLatLngBounds(
        bounds,
        80,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isCirio =
        _eventoAtual ==
        EventoCirio.cirio;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isCirio
              ? 'Círio de Nazaré'
              : 'Trasladação do Círio',
        ),
      ),

      body: Stack(
        children: [
          GoogleMap(
            // Posição inicial do mapa
            initialCameraPosition:
                const CameraPosition(
                  target:
                      MapConstants
                          .basilica,

                  zoom: 13,
                ),

            // Marcadores exibidos
            markers: _markers,

            // Rotas exibidas
            polylines: _polylines,

            // Exibe localização atual do usuário
            myLocationEnabled: true,

            // Exibe botão padrão de localização
            myLocationButtonEnabled:
                true,

            // Armazena controlador do mapa
            onMapCreated: (controller) {
              _mapController =
                  controller;
            },
          ),

          // Botão para alternar evento exibido
          MapToggleButton(
            isCirio: isCirio,

            onPressed: () {
              setState(() {
                _eventoAtual =
                    isCirio
                        ? EventoCirio
                            .translacao
                        : EventoCirio
                            .cirio;
              });

              _atualizarMapa();
            },
          ),

          // Botão de centralização do mapa
          CenterMapButton(
            onPressed:
                _centralizarMapa,
          ),
        ],
      ),
    );
  }
}