import 'dart:io';
import 'package:video_compress/video_compress.dart';

abstract class CompressionDataSource {
  Future<File> compressVideo(File video);
  Future<void> dispose();
}

class CompressionDataSourceImpl implements CompressionDataSource {
  @override
  Future<File> compressVideo(File video) async {
    final info = await VideoCompress.compressVideo(
      video.path,
      quality: VideoQuality.MediumQuality,
      deleteOrigin: false,
    );
    if (info == null || info.file == null) {
      return video;
    }

    return info.file!;
  }

  @override
  Future<void> dispose() async {
    await VideoCompress.cancelCompression();
    await VideoCompress.deleteAllCache();
  }
}
