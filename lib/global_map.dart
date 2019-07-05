import 'package:flutter/foundation.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';


class GlobalMap extends State<GlobalMapWidget> {

  MapboxMapController controller;

  void _onMapCreated(MapboxMapController controller) {
    this.controller = controller;
//    controller.onCircleTapped.add(_onCircleTapped);
  }

  @override
  Widget build(BuildContext context) {
    return MapboxMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: LatLng(-33.852, 151.211),
            zoom: 11.0,
          ),
      gestureRecognizers:
      <Factory<OneSequenceGestureRecognizer>>[
        Factory<OneSequenceGestureRecognizer>(
              () => EagerGestureRecognizer(),
        ),
      ].toSet(),
    );
  }

  @override
  void dispose() {
//    controller?.onCircleTapped?.remove(_onCircleTapped);
    super.dispose();
  }

}

class GlobalMapWidget extends StatefulWidget {

  @override
  State<GlobalMapWidget> createState() => GlobalMap();

}

