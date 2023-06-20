import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medi_track_dora/components/pacienteAdd/paciente_add.dart';

import '../../pacienteHome/in_memory_paciente_repository.dart';
import '../../pacienteHome/paciente.dart';

class PacienteAddPage extends StatelessWidget {
  const PacienteAddPage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario Nuevo Paciente'),
      ),
      body: BlocProvider(
        create: (context) =>
            PacienteAddBloc(pacienteRepository: InMemoryPacienteRepository()),
        child: BlocBuilder<PacienteAddBloc, PacienteAddState>(
          builder: (context, state) {
            if (state is PacienteAddFormState) {
              return PacienteAddForm(state: state);
            }
            if (state is ErrorDuringSaved) {
              return Center(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    state.errorMessage,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              );
            }

            if (state is PacienteSavedSuccessfully) {                            
              WidgetsBinding.instance!.addPostFrameCallback((_) {                
                Navigator.pushNamed(context, '/pacienteHome',arguments: true);
              });
            }
            return Center(child: const CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class PacienteAddForm extends StatelessWidget {
  final PacienteAddFormState state;

  final TextEditingController _idController = TextEditingController();
  late final TextEditingController _ciController;
  late final TextEditingController _nombreController;
  late final TextEditingController _apellidoPaternoController;
  late final TextEditingController _apellidoMaternoController;
  late final TextEditingController _fechaNacimientoController;
  late final TextEditingController _sexoController;
  late final TextEditingController _ocupacionController;
  late final TextEditingController _procedenciaController;
  late final TextEditingController _telefonoCelularController;
  late final TextEditingController _telefonoFijoController;
  late final TextEditingController _direccionResidenciaController;

  PacienteAddForm({required this.state, super.key}) {
    //_idController = TextEditingController();
    _ciController = TextEditingController(text: state.ci);
    _nombreController = TextEditingController();
    //_nombreController.set
    _apellidoPaternoController =
        TextEditingController(text: state.apellidoPaterno);
    _apellidoMaternoController =
        TextEditingController(text: state.apellidoMaterno);
    _fechaNacimientoController = TextEditingController(
        text: DateFormat('dd-MM-yyyy').format(state.fechaNacimiento));
    _sexoController = TextEditingController(text: state.sexo.toString());
    _ocupacionController = TextEditingController(text: state.ocupacion);
    _procedenciaController = TextEditingController(text: state.procedencia);
    _telefonoCelularController =
        TextEditingController(text: state.telefonoCelular.toString());
    _telefonoFijoController =
        TextEditingController(text: state.telefonoFijo.toString());
    _direccionResidenciaController =
        TextEditingController(text: state.direccionResidencia);
    print('called');
  }

  @override
  Widget build(BuildContext context) {
    final PacienteAddBloc _pacienteFormBloc =
        BlocProvider.of<PacienteAddBloc>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            TextFormField(
              //controller: _ciController,
              initialValue: state.ci,
              onChanged: (value) {
                _pacienteFormBloc.add(CIChanged(value));
              },
              decoration:
                  const InputDecoration(labelText: 'Carnet de identidad'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              //controller: _nombreController,
              initialValue: state.nombre,
              onChanged: (value) {
                _pacienteFormBloc.add(NombreChanged(value));
              },
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              initialValue: state.apellidoPaterno,
              onChanged: (value) {
                _pacienteFormBloc.add(ApellidoPaternoChanged(value));
              },
              decoration: const InputDecoration(labelText: 'Apellido Paterno'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              initialValue: state.apellidoMaterno,
              onChanged: (value) {
                _pacienteFormBloc.add(ApellidoMaternoChanged(value));
              },
              decoration: const InputDecoration(labelText: 'Apellido Materno'),
            ),
            const SizedBox(height: 16.0),
            _SexoDropdownButton(),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _fechaNacimientoController,
              onTap: () => showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now())
                  .then((value) {
                print("Fecha changed");
                return _pacienteFormBloc
                    .add(FechaNacimientoChanged(value ?? DateTime.now()));
              }),
              // onChanged: (value) {
              //   // Parse the input value to DateTime, and pass it to the Bloc
              //   final dateOfBirth = DateTime.tryParse(value);
              //   if (dateOfBirth != null) {
              //     _pacienteFormBloc.add(FechaNacimientoChanged(dateOfBirth));
              //   }
              // },
              decoration:
                  const InputDecoration(labelText: 'Fecha de nacimiento'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              initialValue: state.ocupacion,
              onChanged: (value) {
                _pacienteFormBloc.add(OcupacionChanged(value));
              },
              decoration: const InputDecoration(labelText: 'Ocupacion'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              initialValue: state.procedencia,
              onChanged: (value) {
                _pacienteFormBloc.add(ProcedenciaChanged(value));
              },
              decoration: const InputDecoration(labelText: 'Procedencia'),
            ),
            // const SizedBox(height: 16.0),
            // TextFormField(
            //   controller: _procedenciaController,
            //   onChanged: (value) {
            //     _pacienteFormBloc.add(ProcedenciaChanged(value));
            //   },
            //   decoration: const InputDecoration(labelText: 'Procedencia'),
            // ),
            const SizedBox(height: 16.0),
            TextFormField(
              initialValue: state.telefonoCelular.toString(),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              onChanged: (value) => _pacienteFormBloc
                  .add(TelefonoCelularChanged(int.tryParse(value) ?? 000000)),
              decoration: const InputDecoration(
                labelText: 'Telefono Celular',
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              initialValue: state.telefonoFijo.toString(),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              onChanged: (value) => _pacienteFormBloc
                  .add(TelefonoFijoChanged(int.tryParse(value) ?? 000000)),
              decoration: const InputDecoration(
                labelText: 'Telefono Fijo',
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              initialValue: state.direccionResidencia,
              onChanged: (value) {
                _pacienteFormBloc.add(DireccionResidenciaChanged(value));
              },
              decoration:
                  const InputDecoration(labelText: 'Direccion de residencia'),
            ),
            ElevatedButton(
              //width: double.infinity,
              onPressed: () {
                _pacienteFormBloc.add(const PacienteSubmit());
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SexoDropdownButton extends StatefulWidget {
  const _SexoDropdownButton();

  @override
  _SexoDropdownButtonState createState() => _SexoDropdownButtonState();
}

class _SexoDropdownButtonState extends State<_SexoDropdownButton> {
  Sexo? sexoSelected;

  @override
  Widget build(BuildContext context) {
    final PacienteAddBloc _pacienteFormBloc =
        BlocProvider.of<PacienteAddBloc>(context);

    sexoSelected ??= (_pacienteFormBloc.state as PacienteAddFormState).sexo;

    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Sexo"),
          DropdownButton<Sexo>(
            key: const Key('newCarForm_brand_dropdownButton'),
            items: Sexo.values.map((Sexo sexo) {
              return DropdownMenuItem<Sexo>(
                value: sexo,
                child: Text(sexo.toString().split('.').last),
              );
            }).toList(),
            value: sexoSelected,
            hint: const Text('Seleccione Sexo'),
            onChanged: (sexo) {
              setState(() {
                sexoSelected = sexo;
              });
              _pacienteFormBloc.add(SexoChanged(sexoSelected!));
            },
          ),
        ],
      ),
    );
  }
}
