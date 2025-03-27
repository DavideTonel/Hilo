import 'dart:io';
import 'dart:developer' as dev;

import 'package:camera/camera.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:roadsyouwalked_app/model/media/constants/private_storage_constants.dart';
import 'package:roadsyouwalked_app/model/media/private_storage_operation_status.dart';

class PrivateStorageMediaManager {
  // TODO: no need to initialize single storage
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

  Future<PrivateStorageOperationStatus> createMediaDirectory(final String creatorId) async {
    final Directory baseDirectory = await getApplicationDocumentsDirectory();
    final String targetDirectoryPath = path.join(
      baseDirectory.path,
      creatorId,
      PrivateStorageConstants.memoryImagesDirectory,
    );
    final Directory directory = Directory(targetDirectoryPath);
    try {
      if (!await directory.exists()) {
        return await directory.create(recursive: true).then((_) => OperatationSuccess());
      } else {
        return OperatationSuccess();
      }
    } catch (e) {
      dev.log(e.toString());
      return OperatationFailure();
    }
  }

  Future<PrivateStorageOperationStatus> saveImage(
      String creatorId,
      XFile image,
      {
        String? name
      }
    ) async {
    try {
      dev.log("save image");
      await createMediaDirectory(creatorId);
      final Directory baseDirectory = await getApplicationDocumentsDirectory();
      final String photoTargetPath = path.join(
        baseDirectory.path,
        creatorId,
        PrivateStorageConstants.memoryImagesDirectory,
        name ?? DateTime.now().millisecondsSinceEpoch.toString(),
      );
      File file = File(photoTargetPath);
      return await file.writeAsBytes(await image.readAsBytes())
        .then((_) => OperatationSuccess());
    } catch (e) {
      dev.log("failed to save image");
      dev.log(e.toString());
      return OperatationFailure();
    }
  }

  // TODO could have an higher layer like MemoryMediaManager
  Future<List<File>> loadImages(
    String creatorId
  ) async {
    try {
      dev.log("load images");
      final Directory baseDirectory = await getApplicationDocumentsDirectory();
      final String targetDirectoryPath = path.join(
        baseDirectory.path,
        creatorId,
        PrivateStorageConstants.memoryImagesDirectory
      );
      dev.log(targetDirectoryPath);
      final Directory targetDirectory = Directory(targetDirectoryPath);
      return targetDirectory.listSync().whereType<File>().toList();
    } catch (e) {
      dev.log("failed to load images");
      dev.log(e.toString());
      return [];
    }
  }
}

// TODO
// [ ] get images in order
