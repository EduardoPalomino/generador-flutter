import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Menú de Navegación',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Inicio'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ExpansionTile(
            leading: Icon(Icons.directions_car),
            title: Text('Gestión de Vehículos'),
            children: [
              ListTile(
                title: Text('Registro de Vehículos'),
                onTap: () {
                  Navigator.pushNamed(context, '/registro-vehiculos');
                },
              ),
              ListTile(
                title: Text('Mantenimiento'),
                onTap: () {
                  Navigator.pushNamed(context, '/mantenimiento');
                },
              ),
              ListTile(
                title: Text('Combustible'),
                onTap: () {
                  Navigator.pushNamed(context, '/combustible');
                },
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configuración'),
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Cerrar sesión'),
            onTap: () {
              Navigator.pushNamed(context, '/logout');
            },
          ),
        ],
      ),
    );
  }
}
