enum FakeDataSize { empty, small, medium, large }

class DevelopmentConfig {
  final bool isDevelopment;
  final FakeDataSize fakeDataSize;
  final int delayOfResponseInSeonds;
  DevelopmentConfig(
      {required this.isDevelopment,
      required this.fakeDataSize,
      required this.delayOfResponseInSeonds});
}

class ProductionConfig {
  final String databaseName;
  ProductionConfig({required this.databaseName});
}

class ApplicationConfiguration {
  final DevelopmentConfig developmentConfig;
  ApplicationConfiguration({required this.developmentConfig});

  factory ApplicationConfiguration.development(
      FakeDataSize fakeDataSize, int delayOfResponseInSeonds) {
    return ApplicationConfiguration(
        developmentConfig: DevelopmentConfig(
            isDevelopment: true,
            fakeDataSize: fakeDataSize,
            delayOfResponseInSeonds: delayOfResponseInSeonds));
  }

  factory ApplicationConfiguration.production() {
    return ApplicationConfiguration(
        developmentConfig: DevelopmentConfig(
            isDevelopment: false,
            fakeDataSize: FakeDataSize.empty,
            delayOfResponseInSeonds: 0));
  }
}
