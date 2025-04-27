import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:roadsyouwalked_app/ui/helper/map_style_helper.dart';

class PositionInMapWidget extends StatefulWidget {
  final double latitude;
  final double longitude;
  final DateTime timestamp;

  const PositionInMapWidget({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  @override
  PositionInMapWidgetState createState() => PositionInMapWidgetState();
}

class PositionInMapWidgetState extends State<PositionInMapWidget> {
  late MapboxMap _mapboxMap;
  Timer? _rotationTimer;
  double _bearing = 0.0;
  late final Point center;

  @override
  void initState() {
    super.initState();
    center = Point(
      coordinates: Position(widget.longitude, widget.latitude),
    ); // Long, Lat
  }

  void _startRotatingCamera() {
    _rotationTimer = Timer.periodic(Duration(milliseconds: 5), (timer) {
      if (_bearing >= 360) {
        _bearing = 0.0;
      }
      _bearing = _bearing + 0.005;

      _mapboxMap.setCamera(
        CameraOptions(
          center: center,
          zoom: 17.6,
          bearing: _bearing,
          pitch: 70.0,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MapWidget(
      onMapCreated: (MapboxMap map) {
        _mapboxMap = map;

        _mapboxMap.style.setStyleImportConfigProperty(
          "basemap",
          "lightPreset",
          MapStyleHelper.instance.getLightPresetFromTime(widget.timestamp),
        );

        _mapboxMap.compass.updateSettings(CompassSettings(enabled: false));
        _mapboxMap.scaleBar.updateSettings(ScaleBarSettings(enabled: false));

        _mapboxMap.setCamera(
          CameraOptions(center: center, zoom: 17.5, bearing: 0.0, pitch: 70.0),
        );

        _startRotatingCamera();
      },
      gestureRecognizers: null,
      styleUri: MapboxStyles.STANDARD,
    );
  }

  @override
  void dispose() {
    _rotationTimer?.cancel();
    super.dispose();
  }
}
