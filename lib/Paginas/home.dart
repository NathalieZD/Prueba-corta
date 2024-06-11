import 'package:flutter/material.dart';
import 'package:prueba_2/Paginas/services/pacientes.dart';
import 'package:prueba_2/Paginas/services/doctores.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DoctorScreen()),
                );
              },
              child: Text('Doctores'),
            ),
            SizedBox(height: 20), // Espacio entre los botones
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PacienteScreen()),
                );
              },
              child: Text('Pacientes'),
            ),
          ],
        ),
      ),
    );
  }
}
