import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';

class IndicatorsExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Indicators Example'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                content: const Text(
                    'Try to disable the location service, and you will see an '
                    'indicator on the top of the map.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(0, 0),
          initialZoom: 1,
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
            indicators: LocationMarkerIndicators(
              serviceDisabled: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: ColoredBox(
                    color: Colors.white.withAlpha(0x80),
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "Please turn on location service.",
                        textAlign: TextAlign.center,
                        style: TextStyle(height: 1.2),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
