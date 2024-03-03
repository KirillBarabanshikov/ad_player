bool isVideoFile(String fileName) {
  String extension = fileName.split('.').last.toLowerCase();
  List<String> videoExtensions = [
    'mp4',
    'webm',
    'avi',
    'mpeg',
    'wmv',
    'mov',
    'mkv'
  ];
  return videoExtensions.contains(extension);
}
