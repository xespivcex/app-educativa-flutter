import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class LumoAsistente extends StatelessWidget {
  final String mensaje;
  final String imagenAsset; // Nueva propiedad para cambiar la imagen
  final Alignment alinhamentoGlobo; // Para decidir si el globo va a la derecha o izquierda
  final FlutterTts flutterTts = FlutterTts();

  LumoAsistente({
    super.key, 
    required this.mensaje, 
    required this.imagenAsset, // Ahora es obligatorio definir la imagen
    this.alinhamentoGlobo = Alignment.topRight, // Por defecto a la derecha
  });

  Future<void> _hablar() async {
    await flutterTts.setLanguage("es-ES"); // Cambiado a es-ES para mayor compatibilidad
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(mensaje);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alinhamentoGlobo == Alignment.topRight 
          ? MainAxisAlignment.end 
          : MainAxisAlignment.start,
      children: [
        // Si el globo debe ir a la izquierda, primero va el texto, luego Lumo
        if (alinhamentoGlobo == Alignment.topLeft) _buildGlobo(),
        
        // Imagen de Lumo
        Image.asset(imagenAsset, height: 140),
        
        // Si el globo debe ir a la derecha (default), primero va Lumo, luego el texto
        if (alinhamentoGlobo == Alignment.topRight) _buildGlobo(),
      ],
    );
  }

  Widget _buildGlobo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 5)],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              mensaje, 
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
            )
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _hablar, 
            child: const Icon(Icons.volume_up, color: Color(0xFF003366), size: 28),
          ),
        ],
      ),
    );
  }
}