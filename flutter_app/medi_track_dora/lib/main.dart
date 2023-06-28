import 'package:flutter/material.dart';
import 'package:medi_track_dora/config/application_configuration.dart';
import 'mainApp/main_app_builder.dart';
import 'package:flutter/widgets.dart';
void main() {
  //ApplicationConfiguration config = ApplicationConfiguration.development(FakeDataSize.small,1);
  WidgetsFlutterBinding.ensureInitialized();
  //sqfliteFfiInit();

  //databaseFactory = databaseFactoryFfi;

  ApplicationConfiguration config = ApplicationConfiguration.production();
  runApp(MainAppBuilder(config: config).build());
}
