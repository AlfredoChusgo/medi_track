import 'dart:convert';
import 'dart:io';
import 'package:faker/faker.dart';
import 'package:uuid/uuid.dart';

enum Sexo { masculino, femenino }

class Paciente {
  Paciente({
    required this.id,
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
  });

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

  // Generate 10 rows of fake data
  for (int i = 0; i < 50; i++) {
    final paciente = Paciente(
      id: uuid.v4(),
      //ci: faker.random.alphaNumeric(8),
      ci:uuid.v4(),
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
      contactosEmergencia: List.generate(
        faker.randomGenerator.integer(10,min: 1),
        (_) => ContactoEmergencia(
          id: uuid.v4(),
          relacionFamiliar: faker.randomGenerator.element(['Padre', 'Madre', 'Hermano', 'Hermana']),
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

  final file = File('data/pacientes.json');
  file.writeAsStringSync(jsonString);

  print('Data saved to: ${file.path}');
}
