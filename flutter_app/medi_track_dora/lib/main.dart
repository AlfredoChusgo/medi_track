import 'package:flutter/material.dart';
import 'package:medi_track_dora/config/application_configuration.dart';
import 'mainApp/main_app_builder.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //sqfliteFfiInit();

  //databaseFactory = databaseFactoryFfi;

  //ApplicationConfiguration config = ApplicationConfiguration.development(FakeDataSize.small,1);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  ApplicationConfiguration config = ApplicationConfiguration.production();

  runApp(MainAppBuilder(config: config).build());
}
