import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

extension XFileX on XFile {
  Future<String> asNoteImageEntity() async {
    final cacheImage = File(this.path);
    final path = (await getApplicationDocumentsDirectory()).path;
    final imageId = const Uuid().v4();
    final newImage =
    await cacheImage.copy('$path/$imageId${extension(this.path)}');
    return newImage.path;
  }
}