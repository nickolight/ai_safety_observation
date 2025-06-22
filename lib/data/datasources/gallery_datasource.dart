import 'dart:io';
import 'package:image_picker/image_picker.dart';

abstract class GalleryDataSource {
  Future<File?> pickVideoFromGallery();
}

class GalleryDataSourceImpl implements GalleryDataSource {
  final picker = ImagePicker();

  @override
  Future<File?> pickVideoFromGallery() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    return pickedFile != null ? File(pickedFile.path) : null;
  }
}
