import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String texto;
  final Key? fieldKey;
  final bool obscureText;  // Añadimos esta propiedad
  final TextEditingController? controller;  // Hacemos que el controlador sea opcional
  final TextInputType keyboardType;  // Tipo de teclado, por defecto es texto
  final TextStyle? textStyle;  // Estilo de texto opcional

  const CustomTextField({
    super.key,
    required this.texto,
    this.fieldKey,
    this.controller,
    this.obscureText = false,  // Valor predeterminado en falso
    this.keyboardType = TextInputType.text,  // Tipo de entrada por defecto
    this.textStyle,  // Estilo de texto opcional
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0), // Añadir margen superior e inferior
      child: TextField(
        key: fieldKey,
        controller: controller,  // Asignamos el controlador si existe
        obscureText: obscureText,  // Usamos la propiedad que hemos recibido
        keyboardType: keyboardType,  // Definimos el tipo de teclado
        style: textStyle,  // Aplicamos el estilo del texto
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: texto,
        ),
      ),
    );
  }
}
