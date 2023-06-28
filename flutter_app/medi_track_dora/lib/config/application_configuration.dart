
enum FakeDataSize { empty,small,medium,large}
class DevelopmentConfig {
  final bool isDevelopment ;
  final FakeDataSize fakeDataSize;
  DevelopmentConfig({required this.isDevelopment, required this.fakeDataSize});
}

class ApplicationConfiguration {
  final DevelopmentConfig developmentConfig;
  ApplicationConfiguration({required this.developmentConfig});
  
  factory ApplicationConfiguration.development(FakeDataSize fakeDataSize){
    return ApplicationConfiguration(developmentConfig: DevelopmentConfig(isDevelopment: true,fakeDataSize: fakeDataSize));
  }

}