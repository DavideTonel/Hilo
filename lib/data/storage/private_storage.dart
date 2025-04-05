import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class PrivatStorage {
  Future<String> saveFile(final String id, final File file, {List<String> additionalSegments = const []}) async {
    final directory = await getApplicationDocumentsDirectory();
    final extension = path.extension(file.path);
    final fullDirectoryPath = path.joinAll([directory.path, ...additionalSegments]);

    await Directory(fullDirectoryPath).create(recursive: true);

    final newPath = path.join(fullDirectoryPath, "$id$extension");
    await file.copy(newPath);
    
    return newPath;
  }
}
