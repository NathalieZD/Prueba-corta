import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PacienteScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pacientes'),
      ),
      body: StreamBuilder(
        stream: _firestore.collection('doctor').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          final doctors = snapshot.data!.docs;
          return ListView.builder(
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              final doctor = doctors[index];
              return ListTile(
                title: Text(doctor['name']),
                subtitle: Text(doctor['specialty']),
                onTap: () {
                  _navigateToCitaScreen(context, doctor.id, doctor['name']);
                },
              );
            },
          );
        },
      ),
    );
  }

  void _navigateToCitaScreen(
      BuildContext context, String doctorId, String doctorName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AgendarCitaScreen(doctorId: doctorId, doctorName: doctorName),
      ),
    );
  }
}

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
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _agendarCita(context);
          },
          child: Text('Agendar Cita'),
        ),
      ),
    );
  }

  void _agendarCita(BuildContext context) {
   
  }
}
