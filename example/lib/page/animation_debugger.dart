import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';

class AnimationDebugger extends StatefulWidget {
  @override
  State<AnimationDebugger> createState() => _AnimationDebuggerState();
}

class _AnimationDebuggerState extends State<AnimationDebugger> {
  LocationMarkerPosition _locationMarkerPosition = LocationMarkerPosition(
    latitude: 0,
    longitude: 0,
    accuracy: 20000,
  );
  LocationMarkerHeading _locationMarkerHeading = LocationMarkerHeading(
    heading: 0,
    accuracy: 1,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Debugger'),
      ),
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(0, 0),
          initialZoom: 8,
          minZoom: 0,
          maxZoom: 18,
        ),
        children: [
          TileLayer(
            urlTemplate:
                "http://{s}.tianditu.gov.cn/vec_w/wmts?SERVICE=WMTS&REQUEST=GetTile&VERSION=1.0.0&LAYER=vec&STYLE=default&TILEMATRIXSET=w&FORMAT=tiles&TILEMATRIX={z}&TILEROW={y}&TILECOL={x}&tk=${dotenv.env['map_key']}",
            subdomains: const ['t0', 't1', 't2', 't3', 't4', 't5', 't6', 't7'],
            userAgentPackageName:
                'net.tlserver6y.flutter_map_location_marker.example',
            maxZoom: 18,
          ),
          AnimatedLocationMarkerLayer(
            position: _locationMarkerPosition,
            heading: _locationMarkerHeading,
            moveAnimationDuration: const Duration(seconds: 2),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      final random = Random();
                      setState(() {
                        _locationMarkerPosition = LocationMarkerPosition(
                          latitude: random.nextDouble() - 0.5,
                          longitude: random.nextDouble() - 0.5,
                          accuracy: random.nextDouble() * 80000 + 20000,
                        );
                      });
                    },
                    heroTag: null,
                    child: const Icon(
                      Icons.my_location,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      final random = Random();
                      setState(() {
                        _locationMarkerHeading = LocationMarkerHeading(
                          heading: random.nextDouble() * pi * 2,
                          accuracy: random.nextDouble() * 0.8 + 0.2,
                        );
                      });
                    },
                    heroTag: null,
                    child: const Icon(
                      Icons.navigation,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
