import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_track_dora/components/contactoEmergencia/view/contacto_emergencia_page.dart';
import 'package:medi_track_dora/components/estadiaPacienteHome/bloc/estadia_paciente_home_bloc.dart';
import 'package:medi_track_dora/components/settings/settings.dart';

import '../components/estadiaPacienteForm/estadia_paciente.dart';
import '../components/estadiaPacienteHome/view/estadia_paciente_home_page.dart';
import '../components/home/view/home_page.dart';
import '../components/pacienteForm/paciente_form.dart';
import '../components/pacienteHome/bloc/paciente_home_bloc.dart';
import '../models/estadia_paciente_model.dart';
import '../models/paciente.dart';
import '../repositories/paciente_repository.dart';
import '../components/pacienteHome/view/paciente_home_page.dart';

class ProductionApp extends StatelessWidget {
  const ProductionApp({required this.pacienteRepository, super.key});

  final PacienteRepository pacienteRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Medi track Dora',
      initialRoute: '/',
      routes: {
        '/': (_) {
          context.read<PacienteHomeBloc>().add(PacienteHomeRefreshEvent());
          return const HomePage();
        },
        '/pacienteHome': (_) {
          context.read<PacienteHomeBloc>().add(PacienteHomeRefreshEvent());
          return const PacienteHomePage();
        },
        '/pacienteAdd': (buildContext) => PacienteFormPage(
            saveButtonText: "Guardar",
            callback: () {
              BlocProvider.of<PacienteFormBloc>(buildContext)
                  .add(const PacientePerformSave());
              //Navigator.pop(buildContext);
            }),
        '/pacienteEdit': (buildContext) => PacienteFormPage(
            saveButtonText: "Actualizar",
            callback: () {
              BlocProvider.of<PacienteFormBloc>(buildContext)
                  .add(const PacientePerformUpdate());
            }),
        '/pacienteDetails': (buildContext) =>
            PacienteFormPage(saveButtonText: "", callback: () {}),
        '/contactoEmergenciaAdd': (buildContext) => ContactoEmergenciaPage(
              model: ContactoEmergencia.empty(),
              saveButtonText: "Guardar",
              callback: (contactoEmergencia) {
                BlocProvider.of<PacienteFormBloc>(context)
                    .add(ContactoEmergenciaAdded(contactoEmergencia));
                Navigator.pop(buildContext);
              },
            ),
        '/estadiaPaciente': (_) {
          context
              .read<EstadiaPacienteHomeBloc>()
              .add(EstadiaPacienteHomeRefreshEvent());
          return const EstadiaPacienteHomePage();
        },
        '/estadiaPacienteFiltered': (_) {
          return const EstadiaPacienteHomePage();
        },

        '/estadiaPacienteAdd': (_) {
          return EstadiaPacienteFormPage(
              saveButtonText: "Guardar",
              callback: (EstadiaPaciente estadiaPaciente) {
                context.read<EstadiaPacienteFormBloc>().add(
                    SaveEstadiaPacienteFormEvent(
                        estadiaPaciente: estadiaPaciente));
              });
        },
        '/estadiaPacienteEdit': (_) {
          return EstadiaPacienteFormPage(
              saveButtonText: "Actualizar",
              callback: (EstadiaPaciente estadiaPaciente) {
                context.read<EstadiaPacienteFormBloc>().add(
                    UpdateEstadiaPacienteFormEvent(
                        estadiaPaciente: estadiaPaciente));
              });
        },
        '/estadiaPacienteDetail': (_) {
          return EstadiaPacienteFormPage(
              saveButtonText: "",
              callback: (EstadiaPaciente estadiaPaciente) {});
        },
        '/settings': (_) {
          //context.read<SettingsBloc>();
          return SettingsPage();
        }
        //'/cart': (_) => const CartPage(),
      },
    );
  }
}
