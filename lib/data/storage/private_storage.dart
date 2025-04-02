import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as path_provider;
import 'package:path_provider/path_provider.dart';
import 'package:roadsyouwalked_app/data/storage/abstract_application_storage.dart';

class PrivateStorage extends AbstractApplicationStorage {
  late final String basePath;

  PrivateStorage() {
    _initializeBasePath();
  }

  Future<void> _initializeBasePath() async {
    basePath = await getApplicationDocumentsDirectory().then((dir) => dir.path);
  }

  @override
  Future<bool> createDirectory(String directoryName, List<String> targetPath) async {
    try {
      return Directory(
        path_provider.join(
          basePath,
          path_provider.joinAll(targetPath),
          directoryName
        )
      ).create(recursive: true).then((_) => true);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<File>> getFilesInDirectory(List<String> targetPath) async {
    try {
      Directory directory = Directory(
        path_provider.join(
          basePath,
          path_provider.joinAll(targetPath)
        )
      );
      if (await directory.exists()) {
        return directory.listSync().whereType<File>().toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> saveFile(String name, List<String> targetPath, Uint8List data) async {
    try {
      Directory directory = Directory(
        path_provider.join(
          basePath,
          path_provider.joinAll(targetPath)
        )
      );
      if (!await directory.exists()) {
        await createDirectory(targetPath.last, targetPath.sublist(0, targetPath.length - 1));
      }
      return await File(
        path_provider.join(
          directory.path,
          path_provider.joinAll(targetPath),
          name
        )
      ).writeAsBytes(data).then((_) => true);
    } catch (e) {
      return false;
    }
  }
}
