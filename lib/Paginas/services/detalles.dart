import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final String docId;
  final String doctorName;

  DoctorDetailsScreen({required this.docId, required this.doctorName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Doctor'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Doctor: $doctorName',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditDoctorScreen(docId: docId),
                ),
              );
            },
            child: Text('Actualizar Doctor'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VerCitasScreen(doctorId: docId),
                ),
              );
            },
            child: Text('Ver Citas'),
          ),
        ],
      ),
    );
  }
}

class VerCitasScreen extends StatelessWidget {
  final String doctorId;

  VerCitasScreen({required this.doctorId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Citas Agendadas'),
      ),
      body: DoctorCitas(doctorId: doctorId),
    );
  }
}

class DoctorCitas extends StatelessWidget {
  final String doctorId;

  DoctorCitas({required this.doctorId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('citas')
          .where('doctor_id', isEqualTo: doctorId)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        final citas = snapshot.data!.docs;
        if (citas.isEmpty) {
          return Center(child: Text('No hay citas agendadas para este doctor'));
        }
        return ListView.builder(
          itemCount: citas.length,
          itemBuilder: (context, index) {
            final cita = citas[index];
            return ListTile(
              title: Text(cita['patient_name']),
              subtitle: Text('Fecha: ${cita['appointment_date']}'),
            );
          },
        );
      },
    );
  }
}

class EditDoctorScreen extends StatelessWidget {
  final String docId;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  String? _name, _specialty;

  EditDoctorScreen({required this.docId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Doctor'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _firestore.collection('doctor').doc(docId).get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          final docData = snapshot.data!.data() as Map<String, dynamic>;
          _name = docData['name'];
          _specialty = docData['specialty'];
          return Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    initialValue: _name,
                    decoration: InputDecoration(labelText: 'Nombre'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Introduce un nombre';
                      }
                      return null;
                    },
                    onSaved: (value) => _name = value,
                  ),
                  TextFormField(
                    initialValue: _specialty,
                    decoration: InputDecoration(labelText: 'Especialidad'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Introduce una especialidad';
                      }
                      return null;
                    },
                    onSaved: (value) => _specialty = value,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _firestore.collection('doctor').doc(docId).update({
                          'name': _name,
                          'specialty': _specialty,
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Actualizar'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}