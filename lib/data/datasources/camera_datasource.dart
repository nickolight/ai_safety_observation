import 'dart:io';
import 'package:image_picker/image_picker.dart';

abstract class CameraDataSource {
  Future<File?> captureVideo();
}

class CameraDataSourceImpl implements CameraDataSource {
  final _picker = ImagePicker();

  @override
  Future<File?> captureVideo() async {
    final pickedFile = await _picker.pickVideo(
      source: ImageSource.camera,
      maxDuration: const Duration(seconds: 30),
    );
    return pickedFile != null ? File(pickedFile.path) : null;
  }
}
