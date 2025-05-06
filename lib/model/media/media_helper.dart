import 'dart:io';
import 'package:image/image.dart' as img_helper;
import 'package:path/path.dart' as path_provider;

class MediaHelper {
  static final MediaHelper instance = MediaHelper._init();

  MediaHelper._init();

  Future<File?> flipImage(File file, {bool horizontal = true}) async {
    final image = await _decodeImage(file);
    if (image != null) {
      final flippedImage = horizontal ? img_helper.flipHorizontal(image) : img_helper.flipVertical(image);
      return await _encodeImage(flippedImage, file);
    } else {
      return null;
    }
  }

  Future<img_helper.Image?> _decodeImage(File file) async {
    final extension = path_provider.extension(file.path);
    switch (extension) {
      case ".png":
        return img_helper.decodePng(await file.readAsBytes());
      case ".jpg":
        return img_helper.decodeJpg(await file.readAsBytes());
      default:
        return null;
    }
  }

  Future<File?> _encodeImage(img_helper.Image image, File originalFile) async {
    final extension = path_provider.extension(originalFile.path);
    switch (extension) {
      case ".png":
        return await originalFile.writeAsBytes(img_helper.encodePng(image), flush: true);
      case ".jpg":
        return await originalFile.writeAsBytes(img_helper.encodeJpg(image), flush: true);
      default:
        return null;
    }
  }
}
