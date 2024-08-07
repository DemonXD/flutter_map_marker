import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';

class CustomizeMarkerExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customize Marker Example'),
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
            style: LocationMarkerStyle(
              marker: const DefaultLocationMarker(
                color: Colors.green,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              markerSize: const Size.square(40),
              accuracyCircleColor: Colors.green.withOpacity(0.1),
              headingSectorColor: Colors.green.withOpacity(0.8),
              headingSectorRadius: 120,
            ),
            moveAnimationDuration: Duration.zero, // disable animation
          ),
        ],
      ),
    );
  }
}
