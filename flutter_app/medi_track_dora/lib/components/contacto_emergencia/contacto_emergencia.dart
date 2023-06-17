
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class ContactoEmergencia extends Equatable {
  const ContactoEmergencia(
      {required this.id,
      required this.relacionFamiliar,
      required this.nombre,
      required this.apellidoMaterno,
      required this.apellidoPaterno,
      required this.telefono,
      required this.direccion});

  final String id;
  final String relacionFamiliar;
  final String nombre;
  final String apellidoMaterno;
  final String apellidoPaterno;
  final int telefono;
  final String direccion;

  @override
  List<Object> get props => [
        id,
        relacionFamiliar,
        nombre,
        apellidoMaterno,
        apellidoPaterno,
        telefono,
        direccion
      ];

  static final empty = ContactoEmergencia(
      id: const Uuid().v4(),
      apellidoMaterno: '',
      apellidoPaterno: '',
      direccion: '',      
      nombre: '',
      relacionFamiliar: '',
      telefono: 0000000);
}