import 'package:flutter/material.dart';
import 'package:medi_track_dora/config/application_configuration.dart';
import 'mainApp/main_app_builder.dart';

void main() {
  ApplicationConfiguration config =
      ApplicationConfiguration(isDevelopment: false);
  runApp(MainAppBuilder(config: config).build());
}
