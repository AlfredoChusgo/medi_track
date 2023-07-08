import 'package:flutter_test/flutter_test.dart';
import 'package:medi_track_dora/components/pacienteHome/bloc/paciente_home_bloc.dart';
import 'package:medi_track_dora/models/paciente.dart';
import 'package:medi_track_dora/repositories/paciente_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

class MockPacienteRepository extends Mock implements PacienteRepository {}

void main() {
  var mockPacientes = [
    Paciente(
        id: "f8a69183-2034-4dba-9dc6-993c126d46a3",
        ci: "942d4b24-954c-4727-a671-3b70e7835637",
        nombre: "Mitchel",
        apellidoPaterno: "Sawayn",
        apellidoMaterno: "Altenwerth",
        fechaNacimiento: DateTime(2017, 9, 7, 17, 30),
        sexo: Sexo.masculino,
        ocupacion: "Senior Web Specialist",
        procedencia: "West Port Charlieside",
        telefonoCelular: 4640108,
        telefonoFijo: 5158854,
        direccionResidencia: "744091 Carolanne Grove",
        contactosEmergencia: const [
          ContactoEmergencia(
              id: "285b727b-4b92-47cb-ac4a-c14cd0f8fd90",
              relacionFamiliar: "Padre",
              nombre: "Hermana",
              apellidoMaterno: "Nienow",
              apellidoPaterno: "Homenick",
              telefono: 2442054,
              direccion: "275107 Aufderhar Crescent",
              isResponsable:false),
              

        ],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        numeroHistoriaClinica : 112),
    Paciente(
        id: "f8a69183-2034-4dba-9dc6-b0574bffabcd",
        ci: "942d4b24-954c-4727-a671-3036e215cb1d",
        nombre: "Keon",
        apellidoPaterno: "Durgan",
        apellidoMaterno: "Berge",
        fechaNacimiento: DateTime(2017, 9, 7, 17, 30),
        sexo: Sexo.masculino,
        ocupacion: "Senior Web Specialist",
        procedencia: "West Port Charlieside",
        telefonoCelular: 4640108,
        telefonoFijo: 5158854,
        direccionResidencia: "744091 Carolanne Grove",
        contactosEmergencia: const [
          ContactoEmergencia(
              id: "285b727b-4b92-47cb-ac4a-c14cd0f8fd90",
              relacionFamiliar: "Padre",
              nombre: "Hermana",
              apellidoMaterno: "Nienow",
              apellidoPaterno: "Homenick",
              telefono: 2442054,
              direccion: "275107 Aufderhar Crescent",
              isResponsable:false)
        ],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        numeroHistoriaClinica : 113),
  ];
  group('PacienteBLOC test', () {
    late PacienteRepository repository;
    setUp(() {
      repository = MockPacienteRepository();
    });
    test('initial state is should be  PacienteHomeLoadingState', () {
      expect(PacienteHomeBloc(pacienteRepository: repository).state,
          PacienteHomeLoadingState());
    });

    group('LoadPacientes', () {
      blocTest<PacienteHomeBloc, PacienteHomeState>(
          "emits PacienteHomeLoaded after fetching list",
          setUp: () async {
            when(repository.getPacientes).thenAnswer((invocation) =>
                Future.delayed(Duration.zero, () => mockPacientes));
          },
          build: () => PacienteHomeBloc(pacienteRepository: repository),
          act: (bloc) => bloc.add(PacienteHomeRefreshEvent()),
          expect: () => [
                PacienteHomeLoadingState(),
                PacienteHomeLoadedState(pacientes: mockPacientes)
              ],
          verify: (_) => verify(repository.getPacientes).called(1));

      blocTest<PacienteHomeBloc, PacienteHomeState>(
          "emits PacienteHomeErrorState after fetching list",
          setUp: () async {
            when(repository.getPacientes).thenThrow(Exception("error during fetching"));
          },
          build: () => PacienteHomeBloc(pacienteRepository: repository),
          act: (bloc) => bloc.add(PacienteHomeRefreshEvent()),
          expect: () => [
                PacienteHomeLoadingState(),
                PacienteHomeErrorState(errorMessage: "error during fetching")
              ],
          verify: (_) => verify(repository.getPacientes).called(1));
    });
  });
}
