class AppConfig {
  final String buildFlavor;
  final String baseURL;
  static AppConfig? _instance;

  factory AppConfig({required String buildFlavor, required String baseURL}) {
    final AppConfig instance =
        _instance ?? AppConfig._internal(buildFlavor, baseURL);
    _instance ??= instance;

    return instance;
  }

  AppConfig._internal(this.buildFlavor, this.baseURL);

  static AppConfig get instance =>
      _instance ??
      AppConfig(buildFlavor: BuildFlavourConstants.dev, baseURL: 'URL');
}

class BuildFlavourConstants {
  static const String dev = "dev";
  static const String prod = "prod";
}
