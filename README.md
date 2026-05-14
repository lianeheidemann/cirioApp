# Círio Map

Aplicativo mobile desenvolvido em Flutter com foco em geolocalização e visualização de rotas utilizando Google Maps.

O projeto apresenta informações relacionadas ao Círio de Nazaré, exibindo no mapa os trajetos oficiais do Círio e da Trasladação, além da localização atual do usuário e uma rota até o ponto inicial do evento.

---

# Objetivo do Projeto

Desenvolver um aplicativo em Flutter capaz de:

- Utilizar um componente de mapa
- Trabalhar com geolocalização
- Exibir rotas e pontos relevantes
- Aplicar conceitos de coordenadas geográficas
- Organizar o código de forma modular

---

# Funcionalidades

## Ponto inicial fixo

O aplicativo exibe no mapa o ponto inicial do Círio de Nazaré através de um marcador fixo.

---

## Rota da Procissão do Círio

Exibe o trajeto oficial da procissão do Círio de Nazaré utilizando coordenadas geográficas e polylines.

---

## Rota da Trasladação

Permite alternar para o trajeto da Trasladação através de um botão na interface.

---

## Localização do usuário

Obtém a localização atual do dispositivo utilizando permissões de GPS.

---

## Rota até o ponto inicial

Traça uma rota simples entre a localização atual do usuário e o ponto inicial do evento selecionado.

---

# Tecnologias Utilizadas

- Flutter
- Dart
- Google Maps Flutter
- Geolocator

---

# Estrutura do Projeto

```text
lib/
│
├── core/
│   └── constants/
│       └── map_constants.dart
│
├── features/
│   └── map/
│       ├── models/
│       │   └── evento_cirio.dart
│       │
│       ├── presentation/
│       │   ├── pages/
│       │   │   └── map_page.dart
│       │   │
│       │   └── widgets/
│       │       ├── center_map_button.dart
│       │       └── map_toggle_button.dart
│       │
│       └── services/
│           └── location_service.dart
│
└── main.dart<img width="542" height="1218" alt="cirio2" src="https://github.com/user-attachments/assets/132b1e6f-7b2f-4337-9b2d-004b5b75a997" />
<img width="546" height="1205" alt="cirio1" src="https://github.com/user-attachments/assets/4f567b2f-74dc-48b8-a548-dc188ac9dac1" />
