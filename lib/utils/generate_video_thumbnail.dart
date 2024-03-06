import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

Future<File> generateVideoThumbnail(
  File video,
  CacheManager cacheManager,
) async {
  final fileInfo =
      await cacheManager.getFileFromCache('thumbnail_${video.basename}');

  if (fileInfo == null) {
    final uint8list = await VideoThumbnail.thumbnailData(
      video: video.path,
      imageFormat: ImageFormat.WEBP,
      quality: 50,
    );

    final file =
        await cacheManager.putFile('thumbnail_${video.basename}', uint8list!);

    return file;
  }

  return fileInfo.file;
}
