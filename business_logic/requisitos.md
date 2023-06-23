PERSONA
id
nombre
apellido_paterno
apellido_materno
fecha_nacimiento
sexo
ocupacion
procedencia
informacion_contacto:
    telefono_celular
    telefono_fijo
    direccion_residencia

CONTACTOS_EMERGENCIA
    relacion_familiar /padre/madre/etc
    nombre
    apellido
    telefono_contacto
    direccion


ESTADIA_PACIENTE
id_paciente
fecha_ingreso
fecha_egreso
acciones_realizadas
observaciones
diagnostico
servicio tipo servicio
estado /enprogreso/cerrado

ESTADIA_PACIENTE
    filtros por fecha de creacion 
    busquedas

    Agregar Estadia
    Details 
    Editar 
    Eliminar

Para registrar una estadia paciente
    primero seleccionar el paciente
    ver lista estadias 
            Agregar Estadia
            Details 
            Editar 
            Eliminar


view estadia paciente
    filtro por fecha por paciente
    ver/editar/eliminar


view estadia_paciente_home
    filtros = [pacientes] /id pacientes
        loadWithFilters
    list = allEstadiaPaciente with paciente incluided

view estadia_paciente_add/edit
    repository_estadia_paciente should receive filters as parameters to get data 
    selecionar Paciente con buscador //crear buscador paciente que retorne paciente
    llenar campos y guardar 






