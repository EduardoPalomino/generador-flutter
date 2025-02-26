import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import '../widgets/menu_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla Principal'),
        leading: MenuButton(), // Botón para abrir el Sidebar
      ),
      drawer: Sidebar(), // Sidebar oculto por defecto
      body: const Center(
        child: Text(
          'Pantalla Principal',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
