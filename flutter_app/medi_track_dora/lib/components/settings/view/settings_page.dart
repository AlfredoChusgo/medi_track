import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../settings.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingsBloc = context.read<SettingsBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is ActionInProgress) {
            return const Expanded(child: Center(child: CircularProgressIndicator()));
          }  
          if (state is DataTransferSuccess) {
            return const Text('Data transfered successfully.');
          } 
          if (state is DataTransferFailure) {
            return Text('Export failed: ${state.errorMessage}');          
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  settingsBloc.add(ExportDataEvent());
                },
                child: Text('Export Data'),
              ),
              ElevatedButton(
                onPressed: () {
                  settingsBloc.add(ImportDataEvent());
                },
                child: Text('Import Data'),
              ),
            ],
          );
        },
      ),
    );
  }
}