import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings_ui/settings_ui.dart';

import '../settings.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingsBloc = context.read<SettingsBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Opciones'),
      ),
      body: BlocListener<SettingsBloc, SettingsState>(
        listenWhen: (previous, current) => current is! SettingsInitial,
        listener: (context, state) {
          // TODO: implement listener
          String title = '';
          String message = '';
          Color color = Colors.black;
          if (state is ExportingInProgress) {
            title = 'Exportacion';
            message = 'Exportacion en progreso';
          }

          if (state is ImportingInProgress) {
            title = 'Importacion';
            message = 'Importacion en progreso';
          }

          if (state is DataTransferFailure) {
            title = 'Error';
            message = state.errorMessage;
            color = Theme.of(context).colorScheme.error;
          }

          if (state is DataTransferSuccess) {
            title = 'Success';
            message = 'Transferencia exitosa!';
            color = Theme.of(context).colorScheme.primary;
          }

          Flushbar(
            duration: const Duration(seconds: 2),
            title: title,
            message: message,

            backgroundColor: color,
          ).show(context);
        },
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return SettingsList(sections: [
              SettingsSection(title: Text('Datos'), tiles: [
                SettingsTile.navigation(
                  title: Text('Exportacion'),
                  leading: Icon(Icons.upload),
                  description:
                      Text('Exportar la base de datos actual y compartirla'),
                  onPressed: (context) {
                    settingsBloc.add(ExportDataEvent());
                  },
                ),
                SettingsTile.navigation(
                  title: Text('Importacion'),
                  leading: Icon(Icons.download),
                  description:
                      Text('Importar una base de datos desde el dispositivo'),
                  onPressed: (context) {
                    settingsBloc.add(ImportDataEvent());
                  },
                ),
                SettingsTile.navigation(
                  title: Text('Exportar datos Excel'),
                  leading: Icon(Icons.table_chart),
                  description:
                      Text('exporta los datos en format csv'),
                  onPressed: (context) {
                    settingsBloc.add(ExportAsCsv());
                  },
                )
              ]),
            ]);
          },
        ),
      ),
    );
  }
}
