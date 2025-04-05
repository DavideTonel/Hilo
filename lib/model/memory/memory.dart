import 'package:roadsyouwalked_app/model/media/media.dart';
import 'package:roadsyouwalked_app/model/memory/memory_data/memory_data.dart';

class Memory {
  final MemoryData data;
  List<Media> mediaList;

  Memory(
    {
      required this.data,
      this.mediaList = const []
    }
  );

  Map<String, dynamic> toMap() {
    return data.toMap();
  }
}
