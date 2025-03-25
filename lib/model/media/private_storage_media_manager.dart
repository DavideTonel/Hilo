import 'dart:io';
import 'dart:developer' as dev;

import 'package:camera/camera.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:roadsyouwalked_app/model/media/private_storage_operation_status.dart';

class PrivateStorageMediaManager {
  Future<PrivateStorageOperationStatus> init() async {
    dev.log("init private storage");
    final Directory baseDirectory = await getApplicationDocumentsDirectory();
    final String directoryPath = path.join(baseDirectory.path, "userTest", "media");
    final Directory directory = Directory(directoryPath);
    try {
      if (!await directory.exists()) {
        return await directory.create(recursive: true).then((_) => OperatationSuccess());
      } else {
        return OperatationSuccess();
      }
    } catch (e) {
      dev.log("failed to init media directory");
      dev.log(e.toString());
      return OperatationFailure();
    }
  }

  Future<PrivateStorageOperationStatus> saveImage(String name, XFile image) async {
    try {
      dev.log("save image");
      final Directory directory = await getApplicationDocumentsDirectory();
      final String filePath = path.join(directory.path, "userTest", "media", name);
      File file = File(filePath);
      return await file.writeAsBytes(await image.readAsBytes())
        .then((_) => OperatationSuccess());
    } catch (e) {
      dev.log("failed to save image");
      dev.log(e.toString());
      return OperatationFailure();
    }
  }

  Future<List<File>> loadImages() async {
    try {
      dev.log("load images");
      final Directory baseDirectory = await getApplicationDocumentsDirectory();
      final String directoryPath = path.join(baseDirectory.path, "userTest", "media");
      dev.log(directoryPath);
      final Directory directory = Directory(directoryPath);
      return directory.listSync().whereType<File>().toList();
    } catch (e) {
      dev.log("failed to load images");
      dev.log(e.toString());
      return [];
    }
  }
}
