import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prueba_2/firebase_options.dart';

class DoctorScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctores'),
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
          final docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final doc = docs[index];
              return ListTile(
                title: Text(doc['name']),
                subtitle: Text(doc['specialty']),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _firestore.collection('doctor').doc(doc.id).delete();
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditDoctorScreen(docId: doc.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDoctorScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddDoctorScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  String? _name, _specialty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Doctor'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
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
                    _firestore.collection('doctor').add({
                      'name': _name,
                      'specialty': _specialty,
                    });
                    Navigator.pop(context);
                  }
                },
                child: Text('Agregar'),
              ),
            ],
          ),
        ),
      ),
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
