import 'package:flutter/material.dart';

class EstilosApp {
  static BoxDecoration obtenerFondoManty() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF001a33), Color(0xFF003366), Color(0xFF004080)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }
}