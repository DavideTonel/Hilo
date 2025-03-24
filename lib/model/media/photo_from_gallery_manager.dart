import 'package:photo_manager/photo_manager.dart';

class PhotoFromGalleryManager {

  Future<void> init() async {
    await hasPermission().then((res) async => {
      if (!res) {
        await PhotoManager.requestPermissionExtend()
      }
    });
  }

  Future<List<AssetEntity>> loadPhotos() async {
    List<AssetPathEntity> assetPaths = await PhotoManager.getAssetPathList(
      type: RequestType.image,
    );

    if (assetPaths.isNotEmpty) {
      AssetPathEntity selectedPath = assetPaths[0];
      return await selectedPath.getAssetListPaged(page: 0, size: 100);
    }
    return [];
  }

  Future<bool> hasPermission() async {
    var res = await PhotoManager.getPermissionState(requestOption: PermissionRequestOption(
      iosAccessLevel: IosAccessLevel.readWrite,
      androidPermission: AndroidPermission(type: RequestType.common, mediaLocation: false)
    ));
    return res.isAuth;
  }
}
