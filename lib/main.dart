import 'lumo_asistente.dart';
import 'estilos_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
// 1. AGREGA ESTOS DOS IMPORTS
import 'package:firebase_core/firebase_core.dart';
import 'firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math'; // Para generar los números aleatorios de los códigos

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (identical(0, 0.0)) {
      // ESTO ES PARA CHROME (Rellena con tus datos de la consola de Firebase)
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "IzaSyAu5a8ZzIRF7guW1ordpwjAQJP_-ONOF3I",
          authDomain: "mantyapp-ab7e7.firebaseapp.com",
          projectId: "mantyapp-ab7e7",
          storageBucket: "mantyapp-ab7e7.firebasestorage.app",
          messagingSenderId: "404550274919",
          appId: "1:404550274919:web:e9f0df044cef56977ce9c2",
        ),
      );
    } else {
      // ESTO ES PARA ANDROID
      await Firebase.initializeApp();
    }
    print("¡Firebase conectado con éxito!");
  } catch (e) {
    print("Error al conectar Firebase: $e");
  }

  runApp(MantyApp());
}

class MantyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MANTY',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Arial'),
      home: InicioScreen(),
    );
  }
}

//Pantalla de inicio
class InicioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. FONDO
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF001a33),
                  Color(0xFF003366),
                  Color(0xFF004080),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/estrellas_fondo.png',
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.5),
            ),
          ),

          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50), // Espacio arriba
                  // LOGO
                  Image.asset('assets/images/logo.png', height: 350),

                  const SizedBox(height: 30),

                  const Text(
                    "¿Qué quieres aprender hoy?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // BOTÓN
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => UsuarioScreen()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 80,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Text(
                        "COMENZAR",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF003366),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- PANTALLA USUARIO
// ---------------- PANTALLA USUARIO (main.dart)
class UsuarioScreen extends StatelessWidget {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> _hablar(String texto) async {
    await flutterTts.setLanguage("es-CL");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(texto);
  }

  @override
  Widget build(BuildContext context) {
    const String fraseLumo = "¡Hola! Soy Lumo, aprendamos juntos.";

    return Scaffold(
      body: Stack(
        children: [
          // 1. FONDO AZUL
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF001a33),
                  Color(0xFF003366),
                  Color(0xFF004080),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // 2. ESTRELLAS DE FONDO
          Positioned.fill(
            child: Image.asset(
              'assets/images/estrellas_fondo.png',
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.5),
            ),
          ),

          // 3. ASISTENTE LUMO
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Image.asset('assets/images/lumo_asistente.png', height: 200),
              ],
            ),
          ),

          // 4. CONTENIDO (Orden: Docente, Tutor, Estudiante)
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 300, left: 40, right: 40),
              child: Column(
                children: [
                  const Text(
                    "Elige tu perfil:",
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // BOTÓN 1: DOCENTES
                  _btnRol(
                    context,
                    "Docentes",
                    'assets/images/icon_docente.png',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RegistroDocenteScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  // BOTÓN 2: TUTORES
                  _btnRol(
                    context,
                    "Tutores",
                    'assets/images/icon_tutores.png',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => FlujoTutorScreen()),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  // BOTÓN 3: ESTUDIANTES
                  _btnRol(
                    context,
                    "Estudiantes",
                    'assets/images/icon_estudiantes.png',
                    () {
                      // Aquí puedes crear una clase similar para el alumno
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FlujoEstudianteScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // 5. BOTÓN NARANJA DE ESCUCHAR
          Positioned(
            bottom: 40,
            right: 30,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 10,
              ),
              icon: const Icon(Icons.volume_up, size: 28),
              label: const Text(
                "Escuchar",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onPressed: () => _hablar(fraseLumo),
            ),
          ),
        ],
      ),
    );
  }

  // WIDGET MEJORADO: Ahora acepta la función 'onPressed' como parámetro
  Widget _btnRol(
    BuildContext c,
    String tipo,
    String rutaImg,
    VoidCallback alPresionar,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF001a33),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onPressed:
          alPresionar, // <--- Ejecuta la navegación que le pasamos arriba
      child: Row(
        children: [
          Image.asset(rutaImg, height: 40),
          const SizedBox(width: 20),
          Text(
            tipo,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}

// Clase genérica para que el botón de estudiantes no tire error al compilar

class FlujoEstudianteScreen extends StatefulWidget {
  @override
  _FlujoEstudianteScreenState createState() => _FlujoEstudianteScreenState();
}

class _FlujoEstudianteScreenState extends State<FlujoEstudianteScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fases exactas de la imagen de estudiante:
  // 2 (Bienvenido/a), 3 (Ingresar código), 4 (Dispositivo Vinculado), 5 (Lista para usar)
  int _faseEstudiante = 2;
  String _codigoIngresado = "";
  String _nombreEstudiante = "";
  String _avatarEstudiante = "ÍCONO usuario1.png"; // Imagen por defecto
  bool _cargando = false;

  // CONEXIÓN REAL CON EL DOCENTE EN FIREBASE
  Future<void> _validarCodigoEstudianteReal(String codigo) async {
    String limpio = codigo.toUpperCase().trim();
    if (limpio.isEmpty) {
      _notificacionError("Por favor, ingresa el código.");
      return;
    }

    setState(() => _cargando = true);

    try {
      // Busca el documento en la base de datos que coincide con el código generado por el docente
      var result = await _firestore
          .collection('comunidades')
          .where('codigoTutor', isEqualTo: limpio)
          .get();

      if (result.docs.isNotEmpty) {
        var datos = result.docs.first.data();
        setState(() {
          _nombreEstudiante = datos['nombreEstudiante'] ?? "Estudiante";
          _avatarEstudiante = datos['avatarEstudiante'] ?? "ÍCONO usuario1.png";
          _faseEstudiante = 4; // Avanza al paso 4: Dispositivo Vinculado
        });
      } else {
        _notificacionError(
          "El código no existe. Pídele el código correcto a tu docente.",
        );
      }
    } catch (e) {
      _notificacionError("Error de conexión. Revisa tu internet.");
    } finally {
      setState(() => _cargando = false);
    }
  }

  void _notificacionError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001a33),
      body: Stack(
        children: [
          // Fondo Estrellado de la App Original
          Positioned.fill(
            child: Image.asset(
              'assets/images/estrellas_fondo.png',
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.4),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                children: [
                  _buildBotonVolverSuperior(),
                  const SizedBox(height: 20),

                  // Renderizado dinámico según la fase del Mockup de Estudiante
                  if (_faseEstudiante == 2) _buildPaso2Bienvenida(),
                  if (_faseEstudiante == 3) _buildPaso3IngresarCodigo(),
                  if (_faseEstudiante == 4) _buildPaso4DispositivoVinculado(),
                  if (_faseEstudiante == 5) _buildPaso5ListaParaUsar(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBotonVolverSuperior() {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton.icon(
        onPressed: () {
          if (_faseEstudiante > 2) {
            setState(() => _faseEstudiante--);
          } else {
            Navigator.pop(context);
          }
        },
        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
        label: const Text(
          "Volver",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  // --- PASO 2: BIENVENIDO/A ---
  Widget _buildPaso2Bienvenida() {
    return Column(
      children: [
        const Text(
          "Bienvenido/a",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/lumo_asistente.png', height: 120),
            const SizedBox(width: 10),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF9C4),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Para comenzar,\nasocia el dispositivo a\nun/a estudiante",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 50),

        // Tarjeta de Selección "Ya tengo un código"
        InkWell(
          onTap: () => setState(() => _faseEstudiante = 3),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.group, size: 40, color: Color(0xFF001a33)),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Ya tengo un código",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF001a33),
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "Conectar dispositivo",
                        style: TextStyle(fontSize: 13, color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- PASO 3: INGRESA EL CÓDIGO DE TU ESTUDIANTE ---
  Widget _buildPaso3IngresarCodigo() {
    return Column(
      children: [
        const Text(
          "Ingresar código",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Ingresa el código de tu estudiante para vincular este dispositivo.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
        ),
        const SizedBox(height: 40),

        // Input centrado grande coherente con el formato del docente (CAM-XXXX)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            onChanged: (v) => _codigoIngresado = v,
            textAlign: TextAlign.center,
            textCapitalization: TextCapitalization.characters,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 4,
            ),
            decoration: InputDecoration(
              hintText: "CAM-XXXX",
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(height: 50),

        if (_cargando)
          const CircularProgressIndicator(color: Colors.white)
        else
          _buildBotonMoradoPlano(
            "Continuar",
            () => _validarCodigoEstudianteReal(_codigoIngresado),
          ),
      ],
    );
  }

  // --- PASO 4: DISPOSITIVO VINCULADO ---
  Widget _buildPaso4DispositivoVinculado() {
    return Column(
      children: [
        const Text(
          "¡Listo!",
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 25),

        // Candado verde de confirmación
        const CircleAvatar(
          radius: 45,
          backgroundColor: Color(0xFF4CAF50),
          child: Icon(Icons.lock, size: 45, color: Colors.white),
        ),
        const SizedBox(height: 20),
        const Text(
          "Este dispositivo está vinculado con éxito.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(height: 35),

        // Tarjeta con información obtenida de Firebase
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: AssetImage('assets/images/$_avatarEstudiante'),
                child: const Icon(Icons.person, size: 30, color: Colors.purple),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _nombreEstudiante,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF001a33),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Dispositivo vinculado con éxito",
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 50),
        _buildBotonMoradoPlano(
          "Finalizar",
          () => setState(() => _faseEstudiante = 5),
        ),
      ],
    );
  }

  // --- PASO 5: ESTUDIANTE LISTO PARA APRENDER ---
  Widget _buildPaso5ListaParaUsar() {
    return Column(
      children: [
        Text(
          "$_nombreEstudiante puede comenzar",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 25),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/lumo_asistente.png', height: 120),
            const SizedBox(width: 10),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF9C4),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "¡Todo listo\npara\naprender!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),

        // Avatar grande central del Estudiante
        CircleAvatar(
          radius: 65,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/images/$_avatarEstudiante'),
            child: const Icon(
              Icons.person,
              size: 50,
              color: Colors.transparent,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          _nombreEstudiante,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Verás tu perfil en la app y podrás entrar directamente.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13),
        ),
        const SizedBox(height: 40),

        // ✅ REDIRECCIÓN INTEGRADA: Salta directo a tu menú de módulos reconociendo al estudiante
        _buildBotonMoradoPlano("Ir al inicio", () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ModulosScreen(
                datosEstudiante: {
                  "nombre": _nombreEstudiante,
                  "avatar": _avatarEstudiante,
                  "codigo": _codigoIngresado,
                },
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildBotonMoradoPlano(String texto, VoidCallback accion) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF8E66EF),
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      onPressed: accion,
      child: Text(
        texto,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class RegistroDocenteScreen extends StatefulWidget {
  @override
  _RegistroDocenteScreenState createState() => _RegistroDocenteScreenState();
}

class _RegistroDocenteScreenState extends State<RegistroDocenteScreen> {
  final FlutterTts _tts = FlutterTts();
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // Instancia de la BD

  int _fase = 0;
  bool _guardando = false;

  final TextEditingController _nombreDocente = TextEditingController();
  final TextEditingController _correoDocente = TextEditingController();
  final TextEditingController _passDocente = TextEditingController();
  final TextEditingController _nombreComunidad = TextEditingController();
  final TextEditingController _nombreEstudiante = TextEditingController();

  String _avatarSeleccionado = "ÍCONO usuario1.png";

  // Variables para mostrar los códigos generados en la última pantalla
  String _codigoTutorGenerado = "";
  String _codigoEstudianteGenerado = "";

  void _hablarSegunFase() async {
    String mensaje = "";
    switch (_fase) {
      case 0:
        mensaje = "¡Bienvenido o bienvenida! ¿Cómo quieres comenzar?";
        break;
      case 1:
        mensaje = "Por favor, completa tus datos y el nombre de la comunidad.";
        break;
      case 2:
        mensaje =
            "Registra a tu estudiante observando las áreas de aprendizaje.";
        break;
      case 3:
        mensaje =
            "¡Listo! La comunidad ha sido creada con éxito. Aquí tienes los códigos de acceso.";
        break;
    }
    await _tts.setLanguage("es-CL");
    await _tts.speak(mensaje);
  }

  // FUNCIÓN PARA GENERAR CÓDIGOS ALEATORIOS (Ej: CAM-4821)
  String _generarCodigoAleatorio(String prefijo) {
    var random = Random();
    int numero = 1000 + random.nextInt(9000); // Genera un número de 4 dígitos
    return "$prefijo-$numero";
  }

  // --- NUEVA FUNCIÓN: GUARDA TODO REAL EN FIREBASE ---
  Future<void> _guardarEstudianteYComunidadEnFirebase() async {
    if (_nombreEstudiante.text.trim().isEmpty) {
      _notificacionError("Por favor, ingresa el nombre del estudiante.");
      _tts.speak("Escribe el nombre del alumno.");
      return;
    }

    setState(() => _guardando = true);

    // Generamos los códigos reales para este registro
    String codigoTutor = _generarCodigoAleatorio("CAM");
    String codigoEstudiante = _generarCodigoAleatorio("LUMO");

    try {
      // Guardamos un nuevo documento con toda la información vinculada en Firestore
      await _firestore.collection('comunidades').add({
        'nombreDocente': _nombreDocente.text.trim(),
        'correoDocente': _correoDocente.text.trim(),
        'nombreComunidad': _nombreComunidad.text.trim(),
        'nombreEstudiante': _nombreEstudiante.text.trim(),
        'avatarEstudiante': _avatarSeleccionado,
        'codigoTutor': codigoTutor,
        'codigoEstudiante': codigoEstudiante,
        'fechaCreacion': FieldValue.serverTimestamp(),
      });

      // Si se guarda con éxito, actualizamos el estado para mostrar los códigos en la pantalla final
      setState(() {
        _codigoTutorGenerado = codigoTutor;
        _codigoEstudianteGenerado = codigoEstudiante;
        _fase = 3; // Avanzamos a la Fase 4: Códigos Generados
      });

      _tts.speak("Estudiante registrado con éxito. Códigos generados.");
    } catch (e) {
      _notificacionError("Error al guardar en la base de datos.");
    } finally {
      setState(() => _guardando = false);
    }
  }

  void _validarYCrearComunidad() {
    if (_nombreDocente.text.isEmpty ||
        _correoDocente.text.isEmpty ||
        _passDocente.text.isEmpty ||
        _nombreComunidad.text.isEmpty) {
      _notificacionError("Completa todos los campos.");
      return;
    }
    if (!_correoDocente.text.contains("@")) {
      _notificacionError("Correo inválido.");
      return;
    }
    setState(() => _fase = 2);
  }

  void _notificacionError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.redAccent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001a33),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/estrellas_fondo.png',
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.4),
            ),
          ),

          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 60),
            child: Column(
              children: [
                if (_fase == 0) _buildPrimerAcceso(),
                if (_fase == 1) _buildFaseDocente(),
                if (_fase == 2) _buildFaseEstudiante(),
                if (_fase == 3) _buildFaseCodigos(),
                const SizedBox(height: 100),
              ],
            ),
          ),
          _buildBotonesNavegacionInferior(),
        ],
      ),
    );
  }

  Widget _buildPrimerAcceso() {
    return Column(
      children: [
        const Text(
          "1. PRIMER ACCESO",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 50),
        Center(
          child: Image.asset(
            'assets/images/LUMO bienvenido docente.png',
            height: 220,
          ),
        ),
        const SizedBox(height: 50),
        _botonBlancoAcceso(
          "Crear comunidad",
          "Soy docente o tutor y quiero crear mi grupo.",
          'assets/images/ÍCONO comunidad.jpg',
          () => setState(() => _fase = 1),
        ),
        const SizedBox(height: 20),
        _botonBlancoAcceso(
          "Ingresar con código",
          "Ya tengo un código de comunidad o estudiante.",
          'assets/images/ÍCONO código.jpg',
          () => _mostrarDialogoCodigo(),
        ),
      ],
    );
  }

  Widget _buildFaseDocente() => Column(
    children: [
      _tituloFase("2. DOCENTE CREA SU COMUNIDAD"),
      _buildFormDocente(),
    ],
  );
  Widget _buildFaseEstudiante() => Column(
    children: [
      _tituloFase("3. DOCENTE AGREGA ESTUDIANTES"),
      _buildFormEstudiante(),
    ],
  );
  Widget _buildFaseCodigos() => Column(
    children: [_tituloFase("4. CÓDIGOS GENERADOS"), _buildPantallaCodigos()],
  );

  Widget _buildFormDocente() {
    return _contenedorBlanco([
      _titulo("Crear comunidad"),
      _input("Nombre del docente", _nombreDocente, Icons.person),
      _input(
        "Correo electrónico",
        _correoDocente,
        Icons.email,
        tipo: TextInputType.emailAddress,
      ),
      _input("Contraseña", _passDocente, Icons.lock, ocultar: true),
      _input("Nombre de la comunidad", _nombreComunidad, Icons.school),
      _botonMorado("✓ Crear comunidad", _validarYCrearComunidad),
    ]);
  }

  Widget _buildFormEstudiante() {
    return _contenedorBlanco([
      _titulo("Agregar estudiante"),
      CircleAvatar(
        radius: 40,
        backgroundImage: AssetImage('assets/images/$_avatarSeleccionado'),
      ),
      const SizedBox(height: 10),
      _input("Nombre del estudiante", _nombreEstudiante, Icons.face),
      _gridIconos(),
      const SizedBox(height: 20),
      const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Áreas de aprendizaje",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      const SizedBox(height: 10),
      _areaDiseno("Lectura", 'assets/images/ÍCONO lectura.png'),
      _areaDiseno("Números", 'assets/images/ÍCONO números.png'),
      _areaDiseno("Dinero", 'assets/images/ÍCONO dinero.png'),
      const SizedBox(height: 25),

      // Botón con indicador de carga para cuando está subiendo los datos a Firebase
      _guardando
          ? const CircularProgressIndicator()
          : _botonMorado(
              "✓ Guardar estudiante",
              _guardarEstudianteYComunidadEnFirebase,
            ),
    ]);
  }

  Widget _buildPantallaCodigos() {
    return _contenedorBlanco([
      const Icon(Icons.emoji_events, color: Colors.orange, size: 60),
      const Text(
        "¡Comunidad creada con éxito!",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.teal,
        ),
      ),
      Text(
        _nombreComunidad.text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFF003366),
        ),
      ),
      const Divider(height: 30),
      // Mostramos los códigos reales generados dinámicamente
      _tarjetaCodigo("Código para el tutor", _codigoTutorGenerado),
      _tarjetaCodigo("Código para la estudiante", _codigoEstudianteGenerado),
      _botonMorado("✓ Finalizar", () => Navigator.pop(context)),
    ]);
  }

  // --- COMPONENTES AUXILIARES ---
  Widget _buildBotonesNavegacionInferior() {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFb388ff),
              shape: const StadiumBorder(),
            ),
            onPressed: () {
              if (_fase > 0) {
                setState(() => _fase--);
              } else {
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.reply, color: Colors.white),
            label: const Text("Volver", style: TextStyle(color: Colors.white)),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: const StadiumBorder(),
            ),
            onPressed: _hablarSegunFase,
            icon: const Icon(Icons.volume_up, color: Colors.black),
            label: const Text(
              "Escuchar",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _botonBlancoAcceso(
    String t,
    String s,
    String img,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(img, height: 50),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    s,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.blue),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogoCodigo() {
    TextEditingController _c = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Ingresar Código"),
        content: TextField(
          controller: _c,
          decoration: const InputDecoration(hintText: "LUMO-XXXX"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cerrar"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Entrar"),
          ),
        ],
      ),
    );
  }

  Widget _gridIconos() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 16,
        itemBuilder: (context, index) {
          String img = "ÍCONO usuario${index + 1}.png";
          return GestureDetector(
            onTap: () => setState(() => _avatarSeleccionado = img),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _avatarSeleccionado == img
                      ? Colors.purple
                      : Colors.transparent,
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/images/$img'),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _areaDiseno(String nombreArea, String rutaImg) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.asset(rutaImg, height: 35, width: 35),
          const SizedBox(width: 15),
          Text(
            nombreArea,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF001a33),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tarjetaCodigo(String t, String c) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(t, style: const TextStyle(fontSize: 12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                c,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.copy, size: 20),
                onPressed: () => Clipboard.setData(ClipboardData(text: c)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _contenedorBlanco(List<Widget> hijos) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(children: hijos),
    );
  }

  Widget _tituloFase(String t) => Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: Text(
      t,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
  Widget _titulo(String t) => Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: Text(
      t,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
  Widget _input(
    String l,
    TextEditingController c,
    IconData i, {
    bool ocultar = false,
    TextInputType tipo = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        obscureText: ocultar,
        keyboardType: tipo,
        decoration: InputDecoration(
          prefixIcon: Icon(i, color: Colors.blue),
          labelText: l,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _botonMorado(String t, VoidCallback a) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFb388ff),
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      onPressed: a,
      child: Text(
        t,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class FlujoTutorScreen extends StatefulWidget {
  @override
  _FlujoTutorScreenState createState() => _FlujoTutorScreenState();
}

class _FlujoTutorScreenState extends State<FlujoTutorScreen> {
  final FlutterTts _tts = FlutterTts();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  int _faseTutor = 2; // Fases: 2 (Ingresar), 3 (Válido), 4 (Confirmación)
  String _codigoIngresado = "";
  String _nombreEstudianteVinculado = "";
  String _avatarEstudianteVinculado = "ÍCONO usuario1.png";
  bool _cargando = false;

  void _hablarSegunFase() async {
    String mensaje = "";
    switch (_faseTutor) {
      case 2:
        mensaje =
            "Para ver el progreso de tu estudiante, ingresa el código que te entregó su docente.";
        break;
      case 3:
        mensaje =
            "Código válido. Te conectarás con $_nombreEstudianteVinculado.";
        break;
      case 4:
        mensaje =
            "¡Listo! Ahora podrás ver el progreso de $_nombreEstudianteVinculado.";
        break;
    }
    await _tts.setLanguage("es-CL");
    await _tts.speak(mensaje);
  }

  Future<void> _validarCodigoTutorReal(String codigo) async {
    String limpio = codigo.toUpperCase().trim();
    if (limpio.isEmpty) {
      _notificacionError("Por favor, ingresa un código.");
      return;
    }

    setState(() => _cargando = true);

    try {
      var result = await _firestore
          .collection('comunidades')
          .where('codigoTutor', isEqualTo: limpio)
          .get();

      if (result.docs.isNotEmpty) {
        var datos = result.docs.first.data();
        setState(() {
          _nombreEstudianteVinculado =
              datos['nombreEstudiante'] ?? "Estudiante";
          _avatarEstudianteVinculado =
              datos['avatarEstudiante'] ?? "ÍCONO usuario1.png";
          _faseTutor = 3;
        });
        _hablarSegunFase();
      } else {
        _notificacionError("El código ingresado no existe o es incorrecto.");
      }
    } catch (e) {
      _notificacionError("Error de conexión. Verifica Firebase o tu internet.");
    } finally {
      setState(() => _cargando = false);
    }
  }

  void _notificacionError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001a33),
      body: Stack(
        children: [
          // RECUPERADO: Fondo Estrellado Original
          Positioned.fill(
            child: Image.asset(
              'assets/images/estrellas_fondo.png',
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.4),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                children: [
                  _buildBotonVolverSuperior(),
                  const SizedBox(height: 30),
                  if (_faseTutor == 2) _buildPantallaPaso2(),
                  if (_faseTutor == 3) _buildPantallaPaso3(),
                  if (_faseTutor == 4) _buildPantallaPaso4(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBotonVolverSuperior() {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton.icon(
        onPressed: () {
          if (_faseTutor > 2) {
            setState(() => _faseTutor = 2);
          } else {
            Navigator.pop(context);
          }
        },
        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
        label: const Text(
          "Volver",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  // --- INTERFAZ 2: ELIGE INGRESAR CON CÓDIGO ---
  Widget _buildPantallaPaso2() {
    return Column(
      children: [
        // RECUPERADO: Tu fila de Lumo original con el globo amarillo
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/lumo_asistente.png', height: 120),
            const SizedBox(width: 10),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF9C4),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Para ver el progreso\nde tu estudiante,\ningresa el código\nque te entregó\nsu docente.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),

        // Caja de instrucción estilo imagen, pero con tu TextField coherente abajo
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.qr_code_scanner,
                size: 36,
                color: Color(0xFF001a33),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Ingresar con código",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF001a33),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Tengo un código para vincularme con mi estudiante",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
        const SizedBox(height: 40),

        // RECUPERADO: Tu TextField original para que el código sea 100% coherente con el docente
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            onChanged: (v) => _codigoIngresado = v,
            textAlign: TextAlign.center,
            textCapitalization: TextCapitalization.characters,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 4,
            ),
            decoration: InputDecoration(
              hintText: "CAM-XXXX",
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        if (_cargando)
          const CircularProgressIndicator(color: Colors.white)
        else
          _botonMoradoEstiloImagen(
            "Continuar",
            () => _validarCodigoTutorReal(_codigoIngresado),
          ),
      ],
    );
  }

  // --- INTERFAZ 3: CÓDIGO VÁLIDO ---
  Widget _buildPantallaPaso3() {
    return Column(
      children: [
        const Text(
          "Ingresar código",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Ingresa el código de tu estudiante para conectarte.",
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
        ),
        const SizedBox(height: 35),

        // Código centrado coherente
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            _codigoIngresado.toUpperCase(),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF001a33),
              letterSpacing: 2,
            ),
          ),
        ),
        const SizedBox(height: 45),
        const CircleAvatar(
          radius: 35,
          backgroundColor: Colors.green,
          child: Icon(Icons.check, size: 45, color: Colors.white),
        ),
        const SizedBox(height: 20),
        const Text(
          "Código válido",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Te conectarás con $_nombreEstudianteVinculado.",
          style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 16),
        ),
        const SizedBox(height: 50),
        _botonMoradoEstiloImagen(
          "Continuar",
          () => setState(() => _faseTutor = 4),
        ),
      ],
    );
  }

  // --- INTERFAZ 4: CONFIRMACIÓN FINAL CORREGIDA ---
  Widget _buildPantallaPaso4() {
    return Column(
      children: [
        const Text(
          "¡Listo!",
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 25),
        const CircleAvatar(
          radius: 50,
          backgroundColor: Colors.green,
          child: Icon(Icons.people, size: 55, color: Colors.white),
        ),
        const SizedBox(height: 30),
        Text(
          "Ahora podrás ver el progreso de\n$_nombreEstudianteVinculado.",
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 35),

        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: AssetImage(
                  'assets/images/$_avatarEstudianteVinculado',
                ),
                child: const Icon(
                  Icons.person,
                  size: 30,
                  color: Colors.purple,
                ), // Corregido sin errorBuilder
              ),
              const SizedBox(width: 20),
              Text(
                _nombreEstudianteVinculado,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF001a33),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 35),
        Text(
          "Siempre que abras la app, verás su progreso.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14),
        ),
        const SizedBox(height: 40),
        _botonMoradoEstiloImagen("Entrar", () {
          // Navegación final del dashboard
        }),
      ],
    );
  }

  Widget _botonMoradoEstiloImagen(String texto, VoidCallback accion) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF8E66EF), // Color morado/violeta
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      onPressed: accion,
      child: Text(
        texto,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// ---------------- MODULOS ----------------

class ModulosScreen extends StatelessWidget {
  // ✅ CAMBIADO: Ahora recibe el mapa completo con los datos reales del alumno conectado
  final Map<String, dynamic> datosEstudiante;
  final FlutterTts flutterTts = FlutterTts();

  // Constructor actualizado
  ModulosScreen({super.key, required this.datosEstudiante});

  Future<void> _hablar(String texto) async {
    await flutterTts.setLanguage("es-LAS");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(texto);
  }

  @override
  Widget build(BuildContext context) {
    // ✅ RECONOCIMIENTO: Extraemos las variables del estudiante de forma segura
    String nombreAlumno = datosEstudiante["nombre"] ?? "Estudiante";
    String avatarAlumno = datosEstudiante["avatar"] ?? "ÍCONO usuario1.png";
    String codigoAlumno = datosEstudiante["codigo"] ?? "";

    // Frase personalizada con el nombre del niño
    String fraseLumo =
        "¡Hola $nombreAlumno! ¿Qué lección quieres aprender hoy?";

    return Scaffold(
      body: Stack(
        children: [
          //FONDO
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF001a33),
                  Color(0xFF003366),
                  Color(0xFF004080),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/estrellas_fondo.png',
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.4),
            ),
          ),

          //LUMO Y PERFIL DEBAJO
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/lumo_asistente2.png',
                  height: 160,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 15),
                // ✅ CAMBIADO: Ahora el texto muestra dinámicamente el nombre real del estudiante reconocido
                Text(
                  "Perfil: $nombreAlumno",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        color: Colors.black45,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // MÓDULOS
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 220),
              child: Wrap(
                spacing: 25,
                runSpacing: 25,
                alignment: WrapAlignment.center,
                children: [
                  // Aquí se le puede seguir pasando la información a cada juego si lo necesitas más adelante
                  _btnModulo(
                    context,
                    "Lectura",
                    'assets/images/icon_lectura.png',
                    LecturaScreen(tipoUsuario: nombreAlumno),
                  ),
                  _btnModulo(
                    context,
                    "Números",
                    'assets/images/icon_numeros.png',
                    NumerosScreen(tipoUsuario: nombreAlumno),
                  ),
                  _btnModulo(
                    context,
                    "Dinero",
                    'assets/images/icon_dinero.png',
                    DineroScreen(tipoUsuario: nombreAlumno),
                  ),
                  _btnModulo(
                    context,
                    "Progreso",
                    'assets/images/icon_progreso.png',
                    ProgresoScreen(tipoUsuario: nombreAlumno),
                  ),
                ],
              ),
            ),
          ),

          // BOTONES INFERIORES AGRANDADOS
          Positioned(
            bottom: 40,
            left: 25,
            right: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // BOTÓN VOLVER (MORADO)
                SizedBox(
                  height: 65,
                  width: 140,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    icon: const Icon(Icons.arrow_back, size: 24),
                    label: const Text(
                      "Volver",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                // BOTÓN ESCUCHAR (NARANJO)
                SizedBox(
                  height: 65,
                  width: 160,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.black,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    icon: const Icon(Icons.volume_up, size: 30),
                    label: const Text(
                      "Escuchar",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () => _hablar(fraseLumo),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _btnModulo(
    BuildContext context,
    String nombre,
    String rutaImg,
    Widget destino,
  ) {
    return SizedBox(
      width: 160,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF001a33),
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: () =>
            Navigator.push(context, MaterialPageRoute(builder: (_) => destino)),
        child: Column(
          children: [
            Image.asset(rutaImg, height: 60),
            const SizedBox(height: 12),
            Text(
              nombre,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

// MÓDULO: LECTURA
class LecturaScreen extends StatefulWidget {
  final String tipoUsuario;
  const LecturaScreen({super.key, required this.tipoUsuario});

  @override
  State<LecturaScreen> createState() => _LecturaScreenState();
}

class _LecturaScreenState extends State<LecturaScreen> {
  final FlutterTts flutterTts = FlutterTts();
  int _faseActual = 0;
  int _indicePalabraActual = 0;

  final List<Map<String, String>> _palabrasLeccion = [
    {'palabra': 'AUTO', 'imagen': 'auto.png', 'audio': 'Auto'},
    {'palabra': 'MANO', 'imagen': 'mano.png', 'audio': 'Mano'},
    {'palabra': 'MESA', 'imagen': 'mesa.png', 'audio': 'Mesa'},
    {'palabra': 'GATO', 'imagen': 'gato.png', 'audio': 'Gato'},
    {'palabra': 'PAN', 'imagen': 'pan.png', 'audio': 'Pan'},
    {'palabra': 'PASTEL', 'imagen': 'pastel.png', 'audio': 'Pastel'},
    {'palabra': 'PERRO', 'imagen': 'perro.png', 'audio': 'Perro'},
    {'palabra': 'SILLA', 'imagen': 'silla.png', 'audio': 'Silla'},
    {'palabra': 'SOL', 'imagen': 'sol.png', 'audio': 'Sol'},
    {'palabra': 'VASO', 'imagen': 'vaso.png', 'audio': 'Vaso'},
  ];

  Future<void> _hablar(String texto) async {
    await flutterTts.setLanguage("es-ES");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(texto);
  }

  void _cambiarFase(int nuevaFase) {
    setState(() => _faseActual = nuevaFase);
    if (nuevaFase == 0) _hablar("¡Vamos a leer!");
    if (nuevaFase == 2)
      _hablar("¡Gran trabajo! Continúa con la siguiente lección.");
  }

  @override
  void initState() {
    super.initState();
    _hablar("¡Vamos a leer!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //  FONDO
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF001a33),
                  Color(0xFF003366),
                  Color(0xFF004080),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/estrellas_fondo.png',
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.4),
            ),
          ),

          //  CONTENIDO DINÁMICO
          SafeArea(
            child: Center(
              child: _faseActual == 0
                  ? _buildInicioLeccion()
                  : _faseActual == 1
                  ? _buildLeccionPalabras()
                  : _buildFinalLeccion(),
            ),
          ),

          // BOTONES INFERIORES FIJOS
          _buildBotonesInferioresAgrandados(),
        ],
      ),
    );
  }

  Widget _buildInicioLeccion() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/lumo_lectura_inicio.png', height: 200),
        const SizedBox(height: 30),
        _btnNivel("INICIAR LECCIÓN", () => _cambiarFase(1)),
      ],
    );
  }

  Widget _buildLeccionPalabras() {
    final palabra = _palabrasLeccion[_indicePalabraActual];
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Image.asset('assets/images/lumo_asistente_base.png', height: 90),
          const SizedBox(height: 15),

          // Imagen del objeto
          Container(
            height: 150,
            child: Image.asset(
              'assets/images/${palabra['imagen']}',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.image_not_supported,
                size: 80,
                color: Colors.white54,
              ),
            ),
          ),

          const SizedBox(height: 10),
          _buildTarjetaPalabra(palabra['palabra']!),
          const SizedBox(height: 25),

          // Botón Siguiente
          SizedBox(
            width: 200,
            height: 60,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF003366),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 5,
              ),
              icon: const Icon(Icons.arrow_forward, size: 28),
              label: const Text(
                "SIGUIENTE",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                if (_indicePalabraActual < _palabrasLeccion.length - 1) {
                  setState(() => _indicePalabraActual++);
                  _hablar(_palabrasLeccion[_indicePalabraActual]['audio']!);
                } else {
                  _cambiarFase(2);
                }
              },
            ),
          ),
          const SizedBox(
            height: 120,
          ), // Espacio para que no lo tapen los botones morado/naranja
        ],
      ),
    );
  }

  Widget _buildFinalLeccion() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/lumo_gran_trabajo.png', height: 200),
        const SizedBox(height: 30),
        _btnNivel("VOLVER AL MENÚ", () => Navigator.pop(context)),
      ],
    );
  }

  Widget _buildTarjetaPalabra(String p) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            p,
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Color(0xFF003366),
            ),
          ),
          const Divider(thickness: 2, height: 25),
          Text(
            p.split('').join(' '),
            style: const TextStyle(
              fontSize: 30,
              color: Color(0xFF003366),
              letterSpacing: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBotonesInferioresAgrandados() {
    return Positioned(
      bottom: 30,
      left: 20,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _btnIconoGrande(
            Icons.arrow_back,
            "Volver",
            Colors.purple,
            () => Navigator.pop(context),
          ),
          _btnIconoGrande(Icons.volume_up, "Escuchar", Colors.orange, () {
            if (_faseActual == 0)
              _hablar("¡Vamos a leer!");
            else if (_faseActual == 1)
              _hablar(_palabrasLeccion[_indicePalabraActual]['audio']!);
            else
              _hablar("¡Gran trabajo! Continúa con la siguiente lección.");
          }),
        ],
      ),
    );
  }

  Widget _btnNivel(String t, VoidCallback o) => SizedBox(
    width: 250,
    height: 60,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      onPressed: o,
      child: Text(
        t,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    ),
  );

  Widget _btnIconoGrande(IconData i, String t, Color c, VoidCallback o) =>
      SizedBox(
        width: 150,
        height: 65,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: c,
            foregroundColor: Colors.white,
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          icon: Icon(i, size: 28),
          label: Text(
            t,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          onPressed: o,
        ),
      );
}

//modulo numero

class NumerosScreen extends StatefulWidget {
  final String tipoUsuario;
  const NumerosScreen({super.key, this.tipoUsuario = ''});

  @override
  _NumerosScreenState createState() => _NumerosScreenState();
}

class _NumerosScreenState extends State<NumerosScreen> {
  final FlutterTts flutterTts = FlutterTts();
  int _fase = 0;
  int _i = 0;
  String _msg = '';

  final List<String> _nombres = [
    'cero',
    'uno',
    'dos',
    'tres',
    'cuatro',
    'cinco',
    'seis',
    'siete',
    'ocho',
    'nueve',
    'diez',
  ];

  final List<Map<String, dynamic>> _preguntas = [
    {
      'p': '¿Cuántas manzanas hay?',
      'img': '2 manzanas.png',
      'lumo': 'LUMO numeros manzanas.png',
      'o': ['5', '2'],
      'r': '2',
    },
    {
      'p': '¿Cuántos lápices hay?',
      'img': 'lapices.png',
      'lumo': 'LUMO numeros lapices.png',
      'o': ['4', '5'],
      'r': '5',
    },
    {
      'p': '¿Cuántas monedas hay?',
      'img': '4 monedas.png',
      'lumo': 'LUMO numeros monedas.png',
      'o': ['10', '4'],
      'r': '4',
    },
    {
      'p': '¿Cuántos billetes hay?',
      'img': 'billete.png',
      'lumo': 'LUMO numeros billete.png',
      'o': ['1', '9'],
      'r': '1',
    },
    {
      'p': '¿Cuántos pasteles hay en el plato?',
      'img': 'plato.png',
      'lumo': 'LUMO numeros plato.png',
      'o': ['3', '0'],
      'r': '0',
    },
  ];

  Future<void> _hablar(String t) async {
    await flutterTts.setLanguage("es-ES");
    await flutterTts.speak(t);
  }

  void _hablarSegunFase() {
    if (_fase == 0)
      _hablar("Nivel 1: Aprendamos los números del cero al diez");
    else if (_fase == 1)
      _hablar(_nombres[_i]);
    else if (_fase == 2)
      _hablar("Nivel 2: Usemos los números en situaciones reales");
    else if (_fase == 3)
      _hablar(_preguntas[_i]['p']);
    else if (_fase == 4)
      _hablar("¡Gran trabajo! Continúa con la siguiente lección.");
  }

  void _verificar(String opcion, String correcta) {
    setState(() {
      if (opcion == correcta) {
        _msg = '¡Correcto!';
        _hablar("Correcto");
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            if (_i < _preguntas.length - 1) {
              _i++;
              _msg = '';
            } else {
              _fase = 4;
              _msg = '';
            }
          });
        });
      } else {
        _msg = 'Inténtalo de nuevo';
        _hablar("Inténtalo de nuevo");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // FONDO
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF001a33),
                  Color(0xFF003366),
                  Color(0xFF004080),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/estrellas_fondo.png',
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.4),
            ),
          ),

          // CONTENIDO CENTRADO
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Centra verticalmente
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Centra horizontalmente
                children: [
                  _construirFase(),
                  const SizedBox(
                    height: 100,
                  ), // Espacio para botones inferiores
                ],
              ),
            ),
          ),

          // BOTONES INFERIORES
          _buildBotonesInferioresAgrandados(),
        ],
      ),
    );
  }

  Widget _construirFase() {
    if (_fase == 0) return _buildIntro("lumo_nivel1.png", 1);
    if (_fase == 1) return _buildNivel1();
    if (_fase == 2) return _buildIntro("lumo_nivel_2.png", 3);
    if (_fase == 3) return _buildNivel2();
    return _buildIntro("LUMO numeros fin.png", 99);
  }

  Widget _buildIntro(String img, int nextFase) {
    String textoBoton = nextFase == 99 ? "VOLVER AL MENÚ" : "INICIAR";
    return Column(
      children: [
        Image.asset('assets/images/$img', height: 220),
        const SizedBox(height: 30),
        SizedBox(
          width: 250,
          height: 60,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () => setState(() {
              if (nextFase == 99)
                Navigator.pop(context);
              else {
                _fase = nextFase;
                _i = 0;
              }
            }),
            child: Text(
              textoBoton,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNivel1() {
    return Column(
      children: [
        Image.asset('assets/images/lumo_numero_base.png', height: 90),
        const SizedBox(height: 15),
        Image.asset('assets/images/${_nombres[_i]}.png', height: 160),
        const SizedBox(height: 15),
        Image.asset('assets/images/carta_${_nombres[_i]}.png', height: 120),
        const SizedBox(height: 25),
        SizedBox(
          width: 200,
          height: 60,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF003366),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              if (_i < 10)
                setState(() => _i++);
              else
                setState(() => _fase = 2);
            },
            child: const Text(
              "SIGUIENTE",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNivel2() {
    var p = _preguntas[_i];
    return Column(
      children: [
        if (p['lumo'] != '')
          Image.asset('assets/images/${p['lumo']}', height: 90),
        const SizedBox(height: 15),
        Image.asset(
          'assets/images/${p['img']}',
          height: 160,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            p['p'],
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: (p['o'] as List)
              .map(
                (op) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    width: 100,
                    height: 70,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF003366),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () => _verificar(op, p['r']),
                      child: Text(
                        op,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 15),
        Text(
          _msg,
          style: const TextStyle(
            color: Colors.yellow,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildBotonesInferioresAgrandados() {
    return Positioned(
      bottom: 30,
      left: 20,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _btnIconoGrande(
            Icons.arrow_back,
            "Volver",
            Colors.purple,
            () => Navigator.pop(context),
          ),
          _btnIconoGrande(
            Icons.volume_up,
            "Escuchar",
            Colors.orange,
            _hablarSegunFase,
          ),
        ],
      ),
    );
  }

  Widget _btnIconoGrande(IconData i, String t, Color c, VoidCallback o) =>
      SizedBox(
        width: 150,
        height: 65,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: c,
            foregroundColor: Colors.white,
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          icon: Icon(i, size: 28),
          label: Text(
            t,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          onPressed: o,
        ),
      );
}

//modulo dinero
class DineroScreen extends StatefulWidget {
  final String tipoUsuario;
  const DineroScreen({super.key, required this.tipoUsuario});

  @override
  State<DineroScreen> createState() => _DineroScreenState();
}

class _DineroScreenState extends State<DineroScreen> {
  final FlutterTts flutterTts = FlutterTts();

  // Fases: 0:Intro, 1:Nivel 1, 2:Trans N2, 3:Juego N2, 4:Trans N3, 5:Juego N3, 6:Final
  int _faseActual = 0;
  int _indiceDineroActual = 0;
  bool _mostrarAnverso = true;

  // Lógica de Niveles 2 y 3
  int _preguntaActualN2 = 0;
  int _preguntaActualN3 = 0;
  bool _mostrarError = false;
  bool _mostrarCheck = false;

  final List<Map<String, String>> _dineroChileno = [
    {'valor': '10', 'audio': 'diez pesos'},
    {'valor': '50', 'audio': 'cincuenta pesos'},
    {'valor': '100', 'audio': 'cien pesos'},
    {'valor': '500', 'audio': 'quinientos pesos'},
    {'valor': '1000', 'audio': 'mil pesos'},
    {'valor': '2000', 'audio': 'dos mil pesos'},
    {'valor': '5000', 'audio': 'cinco mil pesos'},
    {'valor': '10000', 'audio': 'diez mil pesos'},
    {'valor': '20000', 'audio': 'veinte mil pesos'},
  ];

  // NIVEL 2 (Identificación)
  final List<Map<String, dynamic>> _preguntasN2 = [
    {
      'p': '¿Cuál es la moneda de 100 pesos?',
      'imgL': 'LUMO dinero 100 pesos.png',
      'opts': [
        {'img': 'assets/images/500 anverso.png', 'c': false},
        {'img': 'assets/images/balon.png', 'c': false},
        {'img': 'assets/images/100 anverso.png', 'c': true},
      ],
    },
    {
      'p': '¿Cuál es el billete de 2000 pesos?',
      'imgL': 'LUMO dinero 2000 pesos.png',
      'opts': [
        {'img': 'assets/images/20000 anverso.png', 'c': false},
        {'img': 'assets/images/2000 anverso.png', 'c': true},
        {'img': 'assets/images/10000 anverso.png', 'c': false},
      ],
    },
    {
      'p': '¿Cuál es la moneda de 50 pesos?',
      'imgL': 'LUMO dinero 50 pesos.png',
      'opts': [
        {'img': 'assets/images/100 anverso.png', 'c': false},
        {'img': 'assets/images/50 anverso.png', 'c': true},
        {'img': 'assets/images/cd.png', 'c': false},
      ],
    },
    {
      'p': '¿Cuál es el billete de 1000 pesos?',
      'imgL': 'LUMO dinero 1000 pesos.png',
      'opts': [
        {'img': 'assets/images/1000 anverso.png', 'c': true},
        {'img': 'assets/images/10000 anverso.png', 'c': false},
        {'img': 'assets/images/5000 anverso.png', 'c': false},
      ],
    },
    {
      'p': '¿Cuál es la moneda de 500 pesos?',
      'imgL': 'LUMO dinero 500 pesos.png',
      'opts': [
        {'img': 'assets/images/chapa.png', 'c': false},
        {'img': 'assets/images/10 anverso.png', 'c': false},
        {'img': 'assets/images/500 anverso.png', 'c': true},
      ],
    },
    {
      'p': '¿Cuál es el billete de 20000 pesos?',
      'imgL': 'LUMO dinero 20000 pesos.png',
      'opts': [
        {'img': 'assets/images/5000 anverso.png', 'c': false},
        {'img': 'assets/images/1000 anverso.png', 'c': false},
        {'img': 'assets/images/20000 anverso.png', 'c': true},
      ],
    },
  ];

  // NIVEL 3 (Compra con objetos) - Actualizado con imágenes de Lumo
  final List<Map<String, dynamic>> _preguntasN3 = [
    {
      'p': '¿Con cuál billete compras el cuaderno?',
      'imgL': 'LUMO dinero cuaderno.png',
      'obj': 'cuaderno.png',
      'precio': '2.000',
      'opts': [
        {'img': 'assets/images/2000 anverso.png', 'c': true},
        {'img': 'assets/images/1000 anverso.png', 'c': false},
      ],
    },
    {
      'p': '¿Con cuál moneda compras el pan?',
      'imgL': 'LUMO dinero pan.png',
      'obj': 'pan.png',
      'precio': '100',
      'opts': [
        {'img': 'assets/images/500 anverso.png', 'c': false},
        {'img': 'assets/images/100 anverso.png', 'c': true},
      ],
    },
    {
      'p': '¿Con cuál billete compras el balón?',
      'imgL': 'LUMO dinero balón.png',
      'obj': 'balon.png',
      'precio': '10.000',
      'opts': [
        {'img': 'assets/images/10000 anverso.png', 'c': true},
        {'img': 'assets/images/2000 anverso.png', 'c': false},
      ],
    },
    {
      'p': '¿Con cuál moneda compras la manzana?',
      'imgL': 'LUMO dinero manzana.png',
      'obj': 'manzana.png',
      'precio': '500',
      'opts': [
        {'img': 'assets/images/50 anverso.png', 'c': false},
        {'img': 'assets/images/500 anverso.png', 'c': true},
      ],
    },
    {
      'p': '¿Con cuál billete compras el anillo?',
      'imgL': 'LUMO dinero anillo.png',
      'obj': 'anillo.png',
      'precio': '20.000',
      'opts': [
        {'img': 'assets/images/5000 anverso.png', 'c': false},
        {'img': 'assets/images/20000 anverso.png', 'c': true},
      ],
    },
    {
      'p': '¿Con cuál moneda compras la hoja?',
      'imgL': 'LUMO dinero hoja.png',
      'obj': 'hoja.png',
      'precio': '50',
      'opts': [
        {'img': 'assets/images/50 anverso.png', 'c': true},
        {'img': 'assets/images/500 anverso.png', 'c': false},
      ],
    },
  ];

  Future<void> _hablar(String texto) async {
    await flutterTts.setLanguage("es-ES");
    await flutterTts.speak(texto);
  }

  void _hablarContexto() {
    if (_faseActual == 0)
      _hablar("Conozcamos las monedas y billetes de chile..");
    else if (_faseActual == 1)
      _hablar(
        " moneda BILLETE ${_dineroChileno[_indiceDineroActual]['audio']}",
      );
    else if (_faseActual == 2)
      _hablar("Nivel 2. ¡Identifiquemos el dinero!");
    else if (_faseActual == 3)
      _hablar(_preguntasN2[_preguntaActualN2]['p']);
    else if (_faseActual == 4)
      _hablar("Nivel 3. usemos el dinero en situaciones simples?");
    else if (_faseActual == 5)
      _hablar(_preguntasN3[_preguntaActualN3]['p']);
    else if (_faseActual == 6)
      _hablar("¡Excelente trabajo! Has aprendido mucho sobre el dinero.");
  }

  void _retroceder() {
    setState(() {
      _mostrarCheck = false;
      _mostrarError = false;
      if (_faseActual == 6)
        _faseActual = 5;
      else if (_faseActual == 5) {
        if (_preguntaActualN3 > 0)
          _preguntaActualN3--;
        else
          _faseActual = 4;
      } else if (_faseActual == 4)
        _faseActual = 3;
      else if (_faseActual == 3) {
        if (_preguntaActualN2 > 0)
          _preguntaActualN2--;
        else
          _faseActual = 2;
      } else if (_faseActual == 2)
        _faseActual = 1;
      else if (_faseActual == 1) {
        if (_indiceDineroActual > 0)
          _indiceDineroActual--;
        else
          _faseActual = 0;
      } else
        Navigator.pop(context);
    });
    _hablarContexto();
  }

  @override
  void initState() {
    super.initState();
    _hablarContexto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF001a33), Color(0xFF003366)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/estrellas_fondo.png',
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.4),
            ),
          ),
          SafeArea(child: Center(child: _construirContenido())),
          _buildBotonesInferiores(),
        ],
      ),
    );
  }

  Widget _construirContenido() {
    switch (_faseActual) {
      case 0:
        return _buildIntro('lumonivel1.png', "INICIAR LECCION", 1);
      case 1:
        return _buildNivel1();
      case 2:
        return _buildIntro('lumonivel2.png', "CONTINUAR LECCION", 3);
      case 3:
        return _buildJuegoGenerico(
          _preguntasN2[_preguntaActualN2],
          isN3: false,
        );
      case 4:
        return _buildIntro('lumonivel3.png', "CONTINUAR LECCION", 5);
      case 5:
        return _buildJuegoGenerico(_preguntasN3[_preguntaActualN3], isN3: true);
      case 6:
        return _buildPantallaFinal();
      default:
        return const SizedBox();
    }
  }

  Widget _buildIntro(String img, String txt, int next) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset('assets/images/$img', height: 200),
      const SizedBox(height: 30),
      _btnBlanco(txt, () {
        setState(() => _faseActual = next);
        _hablarContexto();
      }),
    ],
  );

  Widget _buildNivel1() {
    final dinero = _dineroChileno[_indiceDineroActual];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/lumobasedinero.png', height: 90),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () => setState(() => _mostrarAnverso = !_mostrarAnverso),
          child: Image.asset(
            'assets/images/${dinero['valor']} ${_mostrarAnverso ? "anverso" : "reverso"}.png',
            height: 180,
          ),
        ),
        const SizedBox(height: 20),
        Image.asset('assets/images/cartel${dinero['valor']}.png', height: 130),
        const SizedBox(height: 30),
        _btnBlanco("SIGUIENTE", () {
          if (_indiceDineroActual < _dineroChileno.length - 1) {
            setState(() {
              _indiceDineroActual++;
              _mostrarAnverso = true;
            });
            _hablarContexto();
          } else {
            setState(() => _faseActual = 2);
            _hablarContexto();
          }
        }),
      ],
    );
  }

  Widget _buildJuegoGenerico(Map<String, dynamic> item, {required bool isN3}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Muestra a Lumo con la imagen correspondiente (sea N2 o N3)
        Image.asset('assets/images/${item['imgL']}', height: 180),
        const SizedBox(height: 10),
        if (isN3) ...[
          // En el Nivel 3 mostramos el objeto y su precio
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Image.asset('assets/images/${item['obj']}', height: 150),
              Container(
                padding: const EdgeInsets.all(5),
                color: Colors.yellow,
                child: Text(
                  "\$${item['precio']}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
        const SizedBox(height: 20),
        ...item['opts']
            .map<Widget>(
              (opt) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: GestureDetector(
                  onTap: () async {
                    if (opt['c']) {
                      setState(() {
                        _mostrarCheck = true;
                        _mostrarError = false;
                      });
                      await Future.delayed(const Duration(seconds: 1));
                      setState(() {
                        _mostrarCheck = false;
                        if (!isN3) {
                          if (_preguntaActualN2 < _preguntasN2.length - 1)
                            _preguntaActualN2++;
                          else
                            _faseActual = 4;
                        } else {
                          if (_preguntaActualN3 < _preguntasN3.length - 1)
                            _preguntaActualN3++;
                          else
                            _faseActual = 6;
                        }
                      });
                      _hablarContexto();
                    } else {
                      setState(() => _mostrarError = true);
                      _hablar("Intenta nuevamente");
                    }
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(opt['img'], height: 100),
                      if (opt['c'] && _mostrarCheck)
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 60,
                        ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
        if (_mostrarError) _errorMsg(),
      ],
    );
  }

  Widget _buildPantallaFinal() => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset('assets/images/lumodinerofin.png', height: 200),
      const SizedBox(height: 20),
      _bubbleText("¡Excelente trabajo! Has aprendido mucho sobre el dinero."),
      const SizedBox(height: 30),
      _btnBlanco("FINALIZAR", () => Navigator.pop(context)),
    ],
  );

  Widget _bubbleText(String txt) => Container(
    padding: const EdgeInsets.all(15),
    margin: const EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      txt,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );

  Widget _errorMsg() => Container(
    margin: const EdgeInsets.only(top: 10),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.black87,
      borderRadius: BorderRadius.circular(10),
    ),
    child: const Text(
      "Intenta nuevamente",
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );

  Widget _buildBotonesInferiores() => Positioned(
    bottom: 30,
    left: 20,
    right: 20,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _btnIcono(Icons.replay, "Volver", Colors.purple, _retroceder),
        _btnIcono(Icons.volume_up, "Escuchar", Colors.orange, _hablarContexto),
      ],
    ),
  );

  Widget _btnBlanco(String t, VoidCallback o) => SizedBox(
    width: 250,
    height: 60,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      onPressed: o,
      child: Text(
        t,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    ),
  );

  Widget _btnIcono(IconData i, String t, Color c, VoidCallback o) => SizedBox(
    width: 150,
    height: 65,
    child: ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: c,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      icon: Icon(i),
      label: Text(t),
      onPressed: o,
    ),
  );
}

// SECCIÓN DE PROGRESO Y LOGROS
class ProgresoScreen extends StatefulWidget {
  final String tipoUsuario; // Agregamos la variable
  const ProgresoScreen({
    super.key,
    required this.tipoUsuario,
  }); // Agregamos el parámetro al constructor

  @override
  _ProgresoScreenState createState() => _ProgresoScreenState();
}

class _ProgresoScreenState extends State<ProgresoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo Manty unificado
          Container(decoration: EstilosApp.obtenerFondoManty()),
          Positioned.fill(
            child: Image.asset(
              'assets/images/estrellas_fondo.png',
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.5),
            ),
          ),

          // Contenido
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 60),
                const Icon(Icons.emoji_events, size: 80, color: Colors.amber),
                const SizedBox(height: 10),
                const Text(
                  "¡Mira tus logros!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),

                // Lista de progresos
                _tarjetaProgreso(
                  "Lectura",
                  Historial.lectura,
                  10,
                  Colors.orangeAccent,
                ),
                _tarjetaProgreso(
                  "Números",
                  Historial.numeros,
                  3,
                  Colors.blueAccent,
                ),
                _tarjetaProgreso(
                  "Dinero",
                  Historial.dinero,
                  2,
                  Colors.greenAccent,
                ),
                _tarjetaProgreso(
                  "Compras",
                  Historial.compras,
                  3,
                  Colors.purpleAccent,
                ),
              ],
            ),
          ),

          // Botón para volver atrás fácilmente
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tarjetaProgreso(String titulo, int puntos, int total, Color color) {
    double porcentaje = total > 0 ? (puntos / total).clamp(0.0, 1.0) : 0.0;

    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        leading: SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(
            value: porcentaje,
            backgroundColor: Colors.grey.shade300,
            color: color,
            strokeWidth: 6,
          ),
        ),
        title: Text(
          titulo,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          "Puntaje: $puntos de $total",
          style: TextStyle(color: Colors.grey.shade700),
        ),
        trailing: Icon(
          puntos >= total && total > 0 ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 30,
        ),
      ),
    );
  }
}

class Historial {
  static int lectura = 0;
  static int numeros = 0;
  static int dinero = 0;
  static int compras = 0;
  static String nombreEstudiante = "";
  static String avatarActual = "";
  static String idDocumento = ""; // Para saber qué documento actualizar

  // Función para cargar los datos desde Firebase al iniciar
  static void cargarDesdeFirebase(Map<String, dynamic> data, String docId) {
    lectura = data['progreso_lectura'] ?? 0;
    numeros = data['progreso_numeros'] ?? 0;
    dinero = data['progreso_dinero'] ?? 0;
    nombreEstudiante = data['nombre'] ?? "";
    avatarActual = data['avatar'] ?? "";
    idDocumento = docId;
  }
}
