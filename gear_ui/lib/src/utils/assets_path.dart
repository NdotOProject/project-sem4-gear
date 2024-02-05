class AssetsPath {
  final String _folder;

  AssetsPath._({required String folder}) : _folder = folder;

  String _file(String name) {
    return _folder + name;
  }

  static String fallbackImage(String name) {
    return AssetsPath._(folder: "assets/images/fallback/")._file(name);
  }

  static String logoImage(String name) {
    return AssetsPath._(folder: "assets/images/logo/")._file(name);
  }

  static String sidebarImage(String name) {
    return AssetsPath._(folder: "assets/images/sidebar/")._file(name);
  }
}
