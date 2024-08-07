import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';

class StreamDebugger extends StatefulWidget {
  @override
  State<StreamDebugger> createState() => _StreamDebuggerState();
}

class _StreamDebuggerState extends State<StreamDebugger> {
  late Stream<LocationMarkerPosition> _stream;
  LocationMarkerPosition _locationMarkerPosition = LocationMarkerPosition(
    latitude: 0,
    longitude: 0,
    accuracy: 20000,
  );

  @override
  void initState() {
    super.initState();
    _stream = Stream.value(_locationMarkerPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Debugger'),
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
          CurrentLocationLayer(
            positionStream: _stream,
            moveAnimationDuration: const Duration(seconds: 2),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      final random = Random();
                      setState(() {
                        _stream =
                            Stream.periodic(const Duration(seconds: 1), (_) {
                          return _locationMarkerPosition =
                              LocationMarkerPosition(
                            latitude: _locationMarkerPosition.latitude - 0.05,
                            longitude: _locationMarkerPosition.longitude,
                            accuracy: random.nextDouble() * 80000 + 20000,
                          );
                        });
                      });
                    },
                    heroTag: null,
                    child: const Icon(
                      Icons.vertical_align_bottom,
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
                        _stream =
                            Stream.periodic(const Duration(seconds: 2), (_) {
                          return _locationMarkerPosition =
                              LocationMarkerPosition(
                            latitude: _locationMarkerPosition.latitude + 0.1,
                            longitude: _locationMarkerPosition.longitude,
                            accuracy: random.nextDouble() * 80000 + 20000,
                          );
                        });
                      });
                    },
                    heroTag: null,
                    child: const Icon(
                      Icons.vertical_align_top,
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
