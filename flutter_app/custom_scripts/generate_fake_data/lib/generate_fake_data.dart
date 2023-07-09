import 'dart:convert';
import 'dart:io';
import 'package:faker/faker.dart';
import 'package:uuid/uuid.dart';

enum Sexo { masculino, femenino }

enum TipoServicio {
  desconocido,
  psicologia,
  nefrologia,
  medicinaInterna,
  consultaExterna
}

class EstadiaPaciente {
  const EstadiaPaciente(
      {required this.id,
      required this.idPaciente,
      required this.fechaIngreso,
      required this.fechaEgreso,
      required this.accionesRealizadas,
      required this.observaciones,
      required this.diagnostico,
      required this.tipoServicio,
      required this.createdAt,
      required this.updatedAt});

  final String idPaciente;
  final String id;
  final DateTime fechaIngreso;
  final DateTime fechaEgreso;
  final String accionesRealizadas;
  final String observaciones;
  final String diagnostico;
  final TipoServicio tipoServicio;
  final DateTime createdAt;
  final DateTime updatedAt;

  List<Object> get props => [
        id,
        fechaIngreso,
        fechaEgreso,
        accionesRealizadas,
        observaciones,
        diagnostico,
        tipoServicio,
        createdAt,
        updatedAt
      ];

  factory EstadiaPaciente.empty() {
    return EstadiaPaciente(
        id: const Uuid().v4(),
        fechaIngreso: DateTime.now(),
        fechaEgreso: DateTime.now().add(const Duration(days: 7)),
        accionesRealizadas: '',
        observaciones: '',
        diagnostico: '',
        tipoServicio: TipoServicio.desconocido,
        idPaciente: "",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now());
  }

  factory EstadiaPaciente.fromJson(Map<String, dynamic> json) {
    return EstadiaPaciente(
      id: json['id'],
      fechaIngreso: DateTime.parse(json['fechaIngreso']),
      fechaEgreso: DateTime.parse(json['fechaEgreso']),
      accionesRealizadas: json['accionesRealizadas'],
      observaciones: json['observaciones'],
      diagnostico: json['diagnostico'],
      tipoServicio: TipoServicio.values[json['tipoServicio']],
      idPaciente: json['idPaciente'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fechaIngreso': fechaIngreso.toIso8601String(),
      'fechaEgreso': fechaEgreso.toIso8601String(),
      'accionesRealizadas': accionesRealizadas,
      'observaciones': observaciones,
      'diagnostico': diagnostico,
      'tipoServicio': tipoServicio.index,
      'idPaciente': idPaciente,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String()
    };
  }
}

class Paciente {
  Paciente(
      {required this.id,
      required this.ci,
      required this.nombre,
      required this.apellidoPaterno,
      required this.apellidoMaterno,
      required this.fechaNacimiento,
      required this.sexo,
      required this.ocupacion,
      required this.procedencia,
      required this.telefonoCelular,
      required this.telefonoFijo,
      required this.direccionResidencia,
      required this.contactosEmergencia,
      required this.createdAt,
      required this.updatedAt});

  final String id;
  final String ci;
  final String nombre;
  final String apellidoPaterno;
  final String apellidoMaterno;
  final DateTime fechaNacimiento;
  final Sexo sexo;
  final String ocupacion;
  final String procedencia;
  final int telefonoCelular;
  final int telefonoFijo;
  final String direccionResidencia;
  final List<ContactoEmergencia> contactosEmergencia;
  final DateTime createdAt;
  final DateTime updatedAt;
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ci': ci,
      'nombre': nombre,
      'apellidoPaterno': apellidoPaterno,
      'apellidoMaterno': apellidoMaterno,
      'fechaNacimiento': fechaNacimiento.toIso8601String(),
      'sexo': sexo == Sexo.masculino ? 'masculino' : 'femenino',
      'ocupacion': ocupacion,
      'procedencia': procedencia,
      'telefonoCelular': telefonoCelular,
      'telefonoFijo': telefonoFijo,
      'direccionResidencia': direccionResidencia,
      'contactosEmergencia':
          contactosEmergencia.map((contacto) => contacto.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class ContactoEmergencia {
  ContactoEmergencia({
    required this.id,
    required this.relacionFamiliar,
    required this.nombre,
    required this.apellidoMaterno,
    required this.apellidoPaterno,
    required this.telefono,
    required this.direccion,
  });

  final String id;
  final String relacionFamiliar;
  final String nombre;
  final String apellidoMaterno;
  final String apellidoPaterno;
  final int telefono;
  final String direccion;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'relacionFamiliar': relacionFamiliar,
      'nombre': nombre,
      'apellidoMaterno': apellidoMaterno,
      'apellidoPaterno': apellidoPaterno,
      'telefono': telefono,
      'direccion': direccion,
    };
  }
}

void main() {
  final faker = Faker();
  final uuid = Uuid();
  final List<Paciente> pacientes = [];
  final List<EstadiaPaciente> estadiaPacientes = [];

  // Generate 10 rows of fake data
  generatePacientes(uuid, faker, pacientes, 15,"pacientes_medium.json");
  generatePacientes(uuid, faker, pacientes, 15,"pacientes_small.json");
  generatePacientes(uuid, faker, pacientes, 15,"pacientes_large.json");
  generateEstadiaPacientes(pacientes, faker, uuid, estadiaPacientes, "estadia_pacientes_small.json");
  generateEstadiaPacientes(pacientes, faker, uuid, estadiaPacientes, "estadia_pacientes_medium.json");
  generateEstadiaPacientes(pacientes, faker, uuid, estadiaPacientes, "estadia_pacientes_large.json");
}

void generateEstadiaPacientes(List<Paciente> pacientes, Faker faker, Uuid uuid,
    List<EstadiaPaciente> estadiaPacientes, String fileName) {
  for (var paciente in pacientes) {
    var fechaRandom = faker.date.dateTime(minYear: 1950, maxYear: 2003);
    var fechaInicio = fechaRandom.add(Duration(days: -7));
    var fechaFin = fechaRandom.add(Duration(days: 15));

    int count = faker.randomGenerator.integer(5, min: 0);
    for (var i = 0; i < count; i++) {
      final estadiaPaciente = EstadiaPaciente(
          id: uuid.v4(),
          idPaciente: paciente.id,
          fechaIngreso: fechaInicio,
          fechaEgreso: fechaFin,
          accionesRealizadas: faker.lorem.sentences(1).toString(),
          observaciones: faker.lorem.words(15).toString(),
          diagnostico: faker.lorem.words(15).toString(),
          tipoServicio: faker.randomGenerator.element(TipoServicio.values),
          createdAt: fechaRandom.add(Duration(days: -30)),
          updatedAt: fechaRandom.add(Duration(days: -15))
          );
      estadiaPacientes.add(estadiaPaciente);
    }
  }

  final jsonData = estadiaPacientes
      .map((estadiaPaciente) => estadiaPaciente.toJson())
      .toList();
  final jsonString = jsonEncode(jsonData);

  final directory = Directory('data');
  if (!directory.existsSync()) {
    directory.createSync();
  }

  //final file = File('data/estadia_pacientes_medium.json');
  final file = File('data/$fileName');
  file.writeAsStringSync(jsonString);
}

void generatePacientes(
    Uuid uuid, Faker faker, List<Paciente> pacientes, int count, String fileName) {
  // Generate 10 rows of fake data
  for (int i = 0; i < count; i++) {
    final paciente = Paciente(
      id: uuid.v4(),
      //ci: faker.random.alphaNumeric(8),
      ci: uuid.v4(),
      nombre: faker.person.firstName(),
      apellidoPaterno: faker.person.lastName(),
      apellidoMaterno: faker.person.lastName(),
      fechaNacimiento: faker.date.dateTime(minYear: 1950, maxYear: 2003),
      sexo: faker.randomGenerator.boolean() ? Sexo.masculino : Sexo.femenino,
      ocupacion: faker.job.title(),
      procedencia: faker.address.city(),
      telefonoCelular: faker.randomGenerator.integer(9999999),
      telefonoFijo: faker.randomGenerator.integer(9999999),
      direccionResidencia: faker.address.streetAddress(),
      createdAt: faker.date.dateTime(minYear: 1999, maxYear: 2003),
      updatedAt: faker.date.dateTime(minYear: 1999, maxYear: 2003),
      contactosEmergencia: List.generate(
        faker.randomGenerator.integer(10, min: 1),
        (_) => ContactoEmergencia(
          id: uuid.v4(),
          relacionFamiliar: faker.randomGenerator
              .element(['Padre', 'Madre', 'Hermano', 'Hermana']),
          nombre: faker.person.firstName(),
          apellidoMaterno: faker.person.lastName(),
          apellidoPaterno: faker.person.lastName(),
          telefono: faker.randomGenerator.integer(9999999),
          direccion: faker.address.streetAddress(),
        ),
      ),
    );
    pacientes.add(paciente);
  }

  final jsonData = pacientes.map((paciente) => paciente.toJson()).toList();
  final jsonString = jsonEncode(jsonData);

  final directory = Directory('data');
  if (!directory.existsSync()) {
    directory.createSync();
  }

  //final file = File('data/pacientes_medium.json');
  final file = File('data/$fileName');
  file.writeAsStringSync(jsonString);
}

