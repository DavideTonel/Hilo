import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

/// A utility class for saving files to the app's private storage directory.
class PrivateStorage {

  /// Saves a file to the app's private storage under a specified directory path.
  /// Optionally, you can provide additional directory segments to further organize the storage.
  ///
  /// The method ensures that the target directory exists before saving the file. If the directory does not exist, it will be created recursively.
  /// The file is saved with its original extension, and the method supports flexible directory organization with the [additionalSegments] parameter.
  ///
  /// [id] - The unique identifier for the file. This ID is used as the filename (with its original extension) in the specified directory.
  /// [file] - The file to be saved. This should be a [File] object pointing to a valid file on the device.
  /// [additionalSegments] - A list of additional directory segments to further customize the path. Defaults to an empty list. These segments will be appended to the path before the file is saved.
  ///
  /// Returns the full path to the saved file as a [String].
  ///
  /// Example usage:
  /// ```dart
  /// final storage = PrivateStorage();
  /// final savedPath = await storage.saveFile('user_profile_pic', userProfilePicFile, additionalSegments: ['images']);
  /// print(savedPath); // Output: /path/to/app/documents/images/user_profile_pic.jpg
  /// ```
  ///
  /// Throws an error if the file cannot be saved (e.g., due to insufficient permissions or invalid file paths).
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
