import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Crea la comunidad y retorna el ID (Imagen 2 de tus capturas)
  Future<String> crearComunidad(String docente, String curso) async {
    String idComu = (Random().nextInt(9000) + 1000).toString();
    await _db.collection('comunidades').doc(idComu).set({
      'docente': docente,
      'curso': curso,
      'fecha': DateTime.now(),
    });
    return idComu;
  }

  // Guarda al estudiante con su avatar elegido (Imagen 3)
  Future<Map<String, String>> guardarEstudiante(String nombre, String avatar, String idComu) async {
    // Generación de tus códigos CAM y LUMO
    String cam = "CAM-${Random().nextInt(9000) + 1000}";
    String lumo = "LUMO-${Random().nextInt(9000) + 1000}";

    await _db.collection('estudiantes').add({
      'nombre': nombre,
      'avatar': avatar,
      'id_comunidad': idComu,
      'codigo_tutor': cam,
      'codigo_estudiante': lumo,
      'progreso_dinero': 0, // Aquí se guardará el avance de los módulos
      'progreso_lectura': 0,
      'progreso_numeros': 0,
    });

    return {'cam': cam, 'lumo': lumo};
  }

  // Actualiza el progreso cuando el niño termina un módulo
  Future<void> actualizarProgreso(String docId, String modulo, int nivel) async {
    await _db.collection('estudiantes').doc(docId).update({
      'progreso_$modulo': nivel,
      'ultima_actividad': DateTime.now(),
    });
  }
}