import 'dart:io';
import 'package:image/image.dart' as img_helper;
import 'package:path/path.dart' as path_provider;

/// A singleton helper class for handling media-related tasks, such as image manipulation.
///
/// The class is designed to work with [File] objects, providing image processing capabilities
/// such as flipping and saving the modified image back to the original file.
class MediaHelper {
  /// Singleton instance of [MediaHelper].
  static final MediaHelper instance = MediaHelper._init();

  /// Private constructor for [MediaHelper], ensuring that only one instance is created.
  MediaHelper._init();

  /// Flips the given image horizontally or vertically and returns the modified image file.
  ///
  /// This method decodes the image from the provided file, applies the flip operation, and 
  /// encodes the image back to the file. It supports both horizontal and vertical flipping.
  /// If the image cannot be decoded, it returns `null`.
  ///
  /// [file] The image file to be flipped.
  /// [horizontal] A boolean indicating whether to flip the image horizontally (default is true).
  /// 
  /// Returns a [File] object with the flipped image, or `null` if the image cannot be decoded.
  Future<File?> flipImage(File file, {bool horizontal = true}) async {
    final image = await _decodeImage(file);
    if (image != null) {
      final flippedImage = horizontal ? img_helper.flipHorizontal(image) : img_helper.flipVertical(image);
      return await _encodeImage(flippedImage, file);
    } else {
      return null;
    }
  }

  /// Decodes the image from the file based on its extension (PNG/JPG).
  ///
  /// [file] The image file to be decoded.
  ///
  /// Returns a decoded [Image] object if successful, or `null` if the file cannot be decoded.
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

  /// Encodes the modified image and writes it back to the original file.
  ///
  /// [image] The modified image to be written.
  /// [originalFile] The original file to overwrite with the modified image.
  ///
  /// Returns the updated [File] object if the encoding is successful, or `null` if the format is unsupported.
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
