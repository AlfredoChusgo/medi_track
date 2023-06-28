import 'package:flutter/material.dart';
import 'package:medi_track_dora/config/application_configuration.dart';
import 'mainApp/main_app_builder.dart';

void main() {
  ApplicationConfiguration config = ApplicationConfiguration.development(FakeDataSize.empty);
  runApp(MainAppBuilder(config: config).build());
}
