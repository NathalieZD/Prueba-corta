import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AgendarCitaScreen extends StatelessWidget {
  final String doctorId;
  final String doctorName;

  AgendarCitaScreen({required this.doctorId, required this.doctorName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agendar Cita con $doctorName'),
      ),
      body: AgendarCitaForm(),
    );
  }
}

class AgendarCitaForm extends StatefulWidget {
  @override
  _AgendarCitaFormState createState() => _AgendarCitaFormState();
}

class _AgendarCitaFormState extends State<AgendarCitaForm> {
  final _formKey = GlobalKey<FormState>();
  late String _patientName;
  late String _appointmentDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Nombre del paciente'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingresa el nombre del paciente';
                }
                return null;
              },
              onSaved: (value) {
                _patientName = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Fecha de la cita'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingresa la fecha de la cita';
                }
                return null;
              },
              onSaved: (value) {
                _appointmentDate = value!;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _agendarCita();
              },
              child: Text('Agendar Cita'),
            ),
          ],
        ),
      ),
    );
  }

  void _agendarCita() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _addCita(_patientName, _appointmentDate);
    }
  }

  Future<void> _addCita(String patientName, String appointmentDate) async {
    CollectionReference citas = FirebaseFirestore.instance.collection('citas');

    await citas.add({
      'patient_name': patientName,
      'appointment_date': appointmentDate,
    });
  }
}
