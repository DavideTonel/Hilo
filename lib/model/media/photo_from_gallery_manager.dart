import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:photo_manager/photo_manager.dart';

class PhotoFromGalleryManager {

  Future<void> init() async {
    await hasPermission().then((res) async => {
      if (!res) {
        await PhotoManager.requestPermissionExtend()
      }
    });
  }

  Future<bool> hasPermission() async {
    var res = await PhotoManager.getPermissionState(requestOption: PermissionRequestOption(
      iosAccessLevel: IosAccessLevel.readWrite,
      androidPermission: AndroidPermission(type: RequestType.common, mediaLocation: false)
    ));
    return res.isAuth;
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

  //Future<AssetEntity> createAlbum(String name) async {
    //return await PhotoManager.editor.
  //}

  Future<void> savePhoto(String name, XFile data) async {
    await PhotoManager.editor.saveImage(
      await data.readAsBytes(),
      filename: "test.jpg",
      title: "test",
    );
  }

  Future<AssetPathEntity?> getAlbumById(String id) async {
    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList();

    for (var album in albums) {
      if (album.id == id) {
        return album;
      }
    }
    return null;
  }

  Future<List<AssetEntity>> loadPhotosFromAlbum(final String id, {final int page = 0, final int size = 100}) async {
    AssetPathEntity? album = await getAlbumById(id);
    if (album == null) {
      return [];
    }
    return await album.getAssetListPaged(page: page, size: size);
  }
}
