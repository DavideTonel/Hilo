import 'dart:io';
import 'dart:typed_data';

abstract class AbstractApplicationStorage {
  Future<bool> createDirectory(final String directoryName, final List<String> targetPath);
  Future<List<File>> getFilesInDirectory(final List<String> directoryPath);
  Future<bool> saveFile(final String name, final List<String> targetPath, final Uint8List data);
}
