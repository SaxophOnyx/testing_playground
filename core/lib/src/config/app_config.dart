enum Flavor {
  dev,
}

class AppConfig {
  final Flavor flavor;

  AppConfig({
    required this.flavor,
  });

  factory AppConfig.fromFlavor(Flavor flavor) {
    return AppConfig(flavor: flavor);
  }
}
