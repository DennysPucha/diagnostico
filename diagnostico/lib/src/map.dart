import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:diagnostico/src/api/api.dart';
import 'dart:convert';

class MapScreen extends StatefulWidget {
  final String locationType;

  const MapScreen({super.key, required this.locationType});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  List<Marker> markers = [];
  LatLng initialCenter = const LatLng(-33.4569, -70.6483);
  bool noLocationsFound = false;

  @override
  void initState() {
    super.initState();
    fetchLocations();
  }

  void fetchLocations() async {
    try {
      String? response = await Api.getLocationsbyName(widget.locationType);
      final Map<String, dynamic> jsonData = json.decode(response);
      final List<dynamic> data = jsonData['location'] as List<dynamic>;
      setState(() {
        if (data.isNotEmpty) {
          markers = data.map((location) {
            return Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(
                double.parse(location['latitude']),
                double.parse(location['longitude']),
              ),
              child: const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 40.0,
              ),
            );
          }).toList();

          initialCenter = LatLng(
            double.parse(data[0]['latitude']),
            double.parse(data[0]['longitude']),
          );
        } else {
          noLocationsFound = true;
        }
      });
        } catch (e) {
      setState(() {
        noLocationsFound = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa de ${widget.locationType}'),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: initialCenter,
              initialZoom: 10,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(markers: markers),
              const RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    'OpenStreetMap contributors',
                  ),
                ],
              ),
            ],
          ),
          if (noLocationsFound)
            Positioned(
              top: 10,
              left: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.red.withOpacity(0.8),
                child: const Text(
                  'No se encontraron localizaciones para este tipo',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}