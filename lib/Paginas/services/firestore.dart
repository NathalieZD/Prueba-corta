import 'package:cloud_firestore/cloud_firestore.dart';


void addDoctor(String name, String specialty) async {
  CollectionReference doctors = FirebaseFirestore.instance.collection('doctores');

  await doctors.add({
    'name': name,
    'specialty': specialty,
  });
}


Stream<QuerySnapshot> getDoctors() {
  CollectionReference doctors = FirebaseFirestore.instance.collection('doctores');
  return doctors.snapshots();
}


void updateDoctor(String id, String name, String specialty) async {
  CollectionReference doctors = FirebaseFirestore.instance.collection('doctores');

  await doctors.doc(id).update({
    'name': name,
    'specialty': specialty,
  });
}


void deleteDoctor(String id) async {
  CollectionReference doctors = FirebaseFirestore.instance.collection('doctores');
  await doctors.doc(id).delete();
}

Future<void> addCita(String patientName, String appointmentDate) async {
  CollectionReference citas = FirebaseFirestore.instance.collection('citas');

  await citas.add({
    'patient_name': patientName,
    'appointment_date': appointmentDate,
  });
}

Stream<QuerySnapshot> getCitas() {
  CollectionReference citas = FirebaseFirestore.instance.collection('citas');
  return citas.snapshots();
}

Future<void> updateCita(String id, String patientName, String appointmentDate) async {
  CollectionReference citas = FirebaseFirestore.instance.collection('citas');

  await citas.doc(id).update({
    'patient_name': patientName,
    'appointment_date': appointmentDate,
  });
}

Future<void> deleteCita(String id) async {
  CollectionReference citas = FirebaseFirestore.instance.collection('citas');

  await citas.doc(id).delete();
}

Future<void> addPaciente(String name, int age) async {
  CollectionReference pacientes = FirebaseFirestore.instance.collection('pacientes');

  await pacientes.add({
    'name': name,
    'age': age,
  });
}

Stream<QuerySnapshot> getPacientes() {
  CollectionReference pacientes = FirebaseFirestore.instance.collection('pacientes');
  return pacientes.snapshots();
}

Future<void> updatePaciente(String id, String name, int age) async {
  CollectionReference pacientes = FirebaseFirestore.instance.collection('pacientes');

  await pacientes.doc(id).update({
    'name': name,
    'age': age,
  });
}
Future<void> deletePaciente(String id) async {
  CollectionReference pacientes = FirebaseFirestore.instance.collection('pacientes');

  await pacientes.doc(id).delete();
}
