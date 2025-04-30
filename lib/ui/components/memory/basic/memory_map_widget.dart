import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/memory/memory_position_data.dart';
import 'package:roadsyouwalked_app/ui/pages/map/position_in_map_page.dart';

class MemoryMapWidget extends StatelessWidget {
  final double width;
  final double height;
  final MemoryPositionData position;
  final DateTime dateTime;
  final double zoom;
  final double pitch;

  const MemoryMapWidget({
    super.key,
    required this.width,
    required this.height,
    required this.position,
    required this.dateTime,
    required this.zoom,
    required this.pitch
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: PositionInMapPage(
        latitude: position.latitude,
        longitude: position.longitude,
        timestamp: dateTime,
        zoom: zoom,
        pitch: pitch,
      ),
    );
  }
}
