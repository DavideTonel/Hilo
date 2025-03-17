import 'package:photo_manager/photo_manager.dart';
import 'dart:developer' as dev;

class PhotoFromGalleryManager {
  bool hasPermission = false;

  Future<void> init() async {
    // TODO check if permission is already enabled
    await PhotoManager.requestPermissionExtend().then((result) => {
      hasPermission = result.isAuth
    });
  }

  Future<List<AssetEntity>> loadPhotos() async {
    if (hasPermission) {
      dev.log("Yes permission founded when loading photos");
      List<AssetPathEntity> assetPaths = await PhotoManager.getAssetPathList(
        type: RequestType.image,
      );

      if (assetPaths.isNotEmpty) {
        AssetPathEntity selectedPath = assetPaths[0];
        return await selectedPath.getAssetListPaged(page: 0, size: 100);
      }
    }
    dev.log("No permission founded when loading photos");
    return [];
  }
}

class Memory {
  AssetEntity photo;

  Memory({required this.photo});
}
