import 'lumo_asistente.dart';
import 'estilos_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (identical(0, 0.0)) {
      // ESTO ES PARA CHROME 
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
class InicioScreen extends StatefulWidget {
  const InicioScreen({super.key});

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  int _flujoActual = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF001a33), Color(0xFF003366), Color(0xFF004080)],
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    Image.asset('assets/images/logo.png', height: 180),
                    const SizedBox(height: 20),
                    if (_flujoActual == -1) _buildVistaInicial()
                    else if (_flujoActual == 0) _buildVistaEntradaUnificada()
                    else if (_flujoActual == 1) _buildVistaIndividual()
                    else if (_flujoActual == 2) _buildVistaInstitucional(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          if (_flujoActual != -1)
            Positioned(
              bottom: 30,
              left: 20,
              child: FloatingActionButton.extended(
                backgroundColor: Colors.white24,
                elevation: 0,
                onPressed: () => setState(() => _flujoActual = (_flujoActual == 1 || _flujoActual == 2) ? 0 : -1),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                label: const Text("Volver", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildVistaInicial() {
    return Column(
      children: [
        const Text("¿Qué quieres aprender hoy?", textAlign: TextAlign.center, style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.w800, height: 1.2)),
        const SizedBox(height: 40),
        GestureDetector(
          onTap: () => setState(() => _flujoActual = 0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 80),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: const Text("COMENZAR", style: TextStyle(fontSize: 18, color: Color(0xFF003366), fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildVistaEntradaUnificada() {
    return Column(
      children: [
        const Text("Elige tu tipo de ingreso", textAlign: TextAlign.center, style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 30),
        _buildBotonGiganteAccesible(texto: "Tengo una cuenta Manty\n(Ingreso Individual)", icono: Icons.person_rounded, colorFondo: Colors.white.withOpacity(0.9), colorTexto: const Color(0xFF003366), onTap: () => setState(() => _flujoActual = 1)),
        const SizedBox(height: 20),
        _buildBotonGiganteAccesible(texto: "Vengo de un colegio o institución\n(Ingreso Institucional)", icono: Icons.school_rounded, colorFondo: Colors.orange.shade400, colorTexto: Colors.white, onTap: () => setState(() => _flujoActual = 2)),
      ],
    );
  }

  Widget _buildVistaIndividual() {
    return Column(
      children: [
        const Text("Ingreso Individual", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 25),
        _buildBotonSSO(texto: "Continuar con Google", icono: Icons.g_mobiledata, colorBg: Colors.white, colorTxt: Colors.black),
        const SizedBox(height: 12),
        _buildBotonSSO(texto: "Continuar con Apple", icono: Icons.apple, colorBg: Colors.black, colorTxt: Colors.white),
        const SizedBox(height: 12),
        _buildBotonSSO(texto: "Continuar con Facebook", icono: Icons.facebook, colorBg: const Color(0xFF1877F2), colorTxt: Colors.white),
        const SizedBox(height: 12),
        _buildBotonSSO(texto: "Ingresar con Correo", icono: Icons.email_rounded, colorBg: Colors.grey.shade800, colorTxt: Colors.white),
      ],
    );
  }

  Widget _buildVistaInstitucional() {
    return Column(
      children: [
        const Text("Acceso Institucional", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 25),
        // CORRECCIÓN AQUÍ: Usamos Icons.pin_outlined y colores estándar
        _buildBotonSSO(texto: "Código de establecimiento + ID", icono: Icons.pin_outlined, colorBg: Colors.teal.shade600, colorTxt: Colors.white),
        const SizedBox(height: 12),
        _buildBotonSSO(texto: "Escanear Código QR", icono: Icons.qr_code_scanner_rounded, colorBg: Colors.cyan.shade700, colorTxt: Colors.white),
        const SizedBox(height: 12),
        _buildBotonSSO(texto: "Cuenta Google Workspace / Microsoft 365", icono: Icons.domain_rounded, colorBg: Colors.indigo.shade600, colorTxt: Colors.white),
      ],
    );
  }

  Widget _buildBotonGiganteAccesible({required String texto, required IconData icono, required Color colorFondo, required Color colorTexto, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          color: colorFondo,
          borderRadius: BorderRadius.circular(20),
          // CORRECCIÓN AQUÍ: Usamos .withOpacity(0.24) en lugar de black24
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.24), blurRadius: 6, offset: const Offset(0, 3))],
        ),
        child: Row(
          children: [
            Icon(icono, size: 40, color: colorTexto),
            const SizedBox(width: 16),
            Expanded(child: Text(texto, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colorTexto))),
            Icon(Icons.arrow_forward_ios_rounded, size: 20, color: colorTexto.withOpacity(0.7)),
          ],
        ),
      ),
    );
  }

  Widget _buildBotonSSO({required String texto, required IconData icono, required Color colorBg, required Color colorTxt}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(backgroundColor: colorBg, minimumSize: const Size(double.infinity, 55), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), elevation: 2),
      icon: Icon(icono, color: colorTxt, size: 26),
      label: Text(texto, style: TextStyle(color: colorTxt, fontSize: 16, fontWeight: FontWeight.bold)),
      onPressed: () {},
    );
  }
}

// ---------------- PANTALLA USUARIO 
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

  // CONEXIÓN REAL CON EL DOCENTE EN FIREBASE + CÓDIGO MAESTRO INTEGRADO
  Future<void> _validarCodigoEstudianteReal(String codigo) async {
    String limpio = codigo.toUpperCase().trim();
    if (limpio.isEmpty) {
      _notificacionError("Por favor, ingresa el código.");
      return;
    }

    // NUEVO: ACCESO CÓDIGO MAESTRO PARA EL ESTUDIANTE
    if (limpio == "LUMO-MASTER") {
      setState(() {
        _codigoIngresado = limpio;
        _nombreEstudiante = "Supervisor (Modo Alumno)";
        _avatarEstudiante = "ÍCONO usuario1.png";
        _faseEstudiante = 4; // Avanza directo al paso 4 de tu flujo para revisión rápido
      });
      return; // Detiene la ejecución aquí para saltarse Firebase por completo
    }

    setState(() => _cargando = true);

    try {
      // Busca el documento en la base de datos que coincide con el código generado por el docente
      var result = await _firestore
          .collection('comunidades')
          .where('codigoEstudiante', isEqualTo: limpio)
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF001a33), // Color de respaldo
          image: DecorationImage(
            image: AssetImage('assets/images/estrellas_fondo.png'),
            fit: BoxFit.cover, // Esto estira la imagen a toda la pantalla
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Column(
              children: [
                _buildBotonVolverSuperior(),
                const SizedBox(height: 20),

                if (_faseEstudiante == 2) _buildPaso2Bienvenida(),
                if (_faseEstudiante == 3) _buildPaso3IngresarCodigo(),
                if (_faseEstudiante == 4) _buildPaso4DispositivoVinculado(),
                if (_faseEstudiante == 5) _buildPaso5ListaParaUsar(),
              ],
            ),
          ),
        ),
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
        const SizedBox(height: 35),
        
        Image.asset(
          'assets/images/LUMO cuenta estudiante.png', 
          height: 150,
          fit: BoxFit.contain,
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

  // ---  INGRESA EL CÓDIGO DE TU ESTUDIANTE (CON LUMO-XXXX) ---
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
              hintText: "LUMO-XXXX", // Asegurado con el formato del estudiante
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

  // --- DISPOSITIVO VINCULADO ---
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
              Expanded(
                child: Column(
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

  // ---  ESTUDIANTE LISTO PARA APRENDER ---
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
        const SizedBox(height: 35),

        Image.asset(
          'assets/images/LUMO cuenta estudiante.png', 
          height: 150,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 40),

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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Instancia de la BD

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
        mensaje = "Registra a tu estudiante observando las áreas de aprendizaje.";
        break;
      case 3:
        mensaje = "¡Listo! La comunidad ha sido creada con éxito. Aquí tienes los códigos de acceso.";
        break;
    }
    await _tts.setLanguage("es-CL");
    await _tts.speak(mensaje);
  }

  // FUNCIÓN PARA GENERAR CÓDIGOS ALEATORIOS CON SU PREFIJO CORRESPONDIENTE
  String _generarCodigoAleatorio(String prefijo) {
    var random = Random();
    int numero = 1000 + random.nextInt(9000); // Genera un número de 4 dígitos
    return "$prefijo-$numero";
  }

  // --- GUARDA TODO REAL EN FIREBASE SEPARANDO LOS CÓDIGOS ---
  Future<void> _guardarEstudianteYComunidadEnFirebase() async {
    if (_nombreEstudiante.text.trim().isEmpty) {
      _notificacionError("Por favor, ingresa el nombre del estudiante.");
      _tts.speak("Escribe el nombre del alumno.");
      return;
    }

    setState(() => _guardando = true);


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
        _fase = 3; 
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
    //  Forzamos a que el Container decorado use el 100% del ancho y alto de la pantalla
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF001a33), // Color oscuro de respaldo
          image: DecorationImage(
            image: AssetImage('assets/images/estrellas_fondo.png'),
            fit: BoxFit.cover, // Estira y expande el fondo por completo sin cortes
          ),
        ),
        child: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                child: Column(
                  children: [
                    if (_fase == 0) _buildPrimerAcceso(),
                    if (_fase == 1) _buildFaseDocente(),
                    if (_fase == 2) _buildFaseEstudiante(),
                    if (_fase == 3) _buildFaseCodigos(),
                    const SizedBox(height: 100), // Espacio para que el scroll no tape los botones de abajo
                  ],
                ),
              ),
            ),
            _buildBotonesNavegacionInferior(),
          ],
        ),
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
      _tarjetaCodigo("Código para el tutor", _codigoTutorGenerado),
      _tarjetaCodigo("Código para la estudiante", _codigoEstudianteGenerado),
      _botonMorado("✓ Finalizar", () => Navigator.pop(context)),
    ]);
  }

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

  int _faseTutor = 2; // Fases: 2 (Ingresar), 3 (Válido), 4 (Confirmación/Progreso)
  String _codigoIngresado = "";
  String _nombreEstudianteVinculado = "";
  String _avatarEstudianteVinculado = "ÍCONO usuario1.png";
  bool _cargando = false;

  // 📈 VARIABLES DE PROGRESO INTEGRADAS
  int _progresoLectura = 0;
  int _progresoMatematica = 0;
  int _progresoDinero = 0;

  void _hablarSegunFase() async {
    String mensaje = "";
    switch (_faseTutor) {
      case 2:
        mensaje = "Para ver el progreso de tu estudiante, ingresa el código que te entregó su docente.";
        break;
      case 3:
        mensaje = "Código válido. Te conectarás con $_nombreEstudianteVinculado.";
        break;
      case 4:
        mensaje = "¡Listo! Ahora podrás ver el progreso de $_nombreEstudianteVinculado.";
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

    // 🌟 NUEVO: ACCESO CÓDIGO MAESTRO PARA EL TUTOR
    if (limpio == "LUMO-MASTER") {
      setState(() {
        _nombreEstudianteVinculado = "Supervisor (Modo Prueba)";
        _avatarEstudianteVinculado = "ÍCONO usuario1.png";
        
        // Datos de ejemplo para que tu jefa vea cómo funcionan las barras de progreso
        _progresoLectura = 8; 
        _progresoMatematica = 6;
        _progresoDinero = 9;
        
        _faseTutor = 4; // Se salta directo al panel de progresos
      });
      _hablarSegunFase();
      return; // Detiene la ejecución para no buscar en Firebase
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
          _nombreEstudianteVinculado = datos['nombreEstudiante'] ?? "Estudiante";
          _avatarEstudianteVinculado = datos['avatarEstudiante'] ?? "ÍCONO usuario1.png";
          
          _progresoLectura = datos['progresoLectura'] ?? 0;
          _progresoMatematica = datos['progresoMatematica'] ?? 0;
          _progresoDinero = datos['progresoDinero'] ?? 0;
          
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
          Positioned.fill(
            child: Image.asset(
              'assets/images/estrellas_fondo.png',
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.4),
            ),
          ),

          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                        child: Column(
                          children: [
                            _buildBotonVolverSuperior(),
                            const SizedBox(height: 30),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (_faseTutor == 2) _buildPantallaPaso2(),
                                  if (_faseTutor == 3) _buildPantallaPaso3(),
                                  if (_faseTutor == 4) _buildPantallaPaso4(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
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

  Widget _buildPantallaPaso2() {
    return Column(
      children: [
        Center(
          child: Image.asset(
            'assets/images/LUMO código tutor.png', 
            height: 140,
            errorBuilder: (c, e, s) => const SizedBox(
              height: 140, 
              child: Icon(Icons.face, color: Colors.white, size: 80)
            ),
          ),
        ),
        const SizedBox(height: 40),

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

  Widget _buildPantallaPaso4() {
    return Column(
      children: [
        const Text(
          "¡Progreso del Estudiante!",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),

        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white24),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/$_avatarEstudianteVinculado',
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => const Icon(Icons.person, size: 30, color: Colors.purple),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Text(
                _nombreEstudianteVinculado,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),

        _buildTarjetaModulo("Módulo Lectura", _progresoLectura, Colors.orangeAccent),
        const SizedBox(height: 15),
        _buildTarjetaModulo("Módulo Matemática (Números)", _progresoMatematica, Colors.tealAccent),
        const SizedBox(height: 15),
        _buildTarjetaModulo("Simulador de Compras (Dinero)", _progresoDinero, Colors.lightGreenAccent),
        
        const SizedBox(height: 35),
        _botonMoradoEstiloImagen("Finalizar Revisión", () {
          Navigator.pop(context);
        }),
      ],
    );
  }

  Widget _buildTarjetaModulo(String titulo, int progreso, Color colorBarra) {
    double porcentaje = (progreso * 10).clamp(0, 100) / 100.0; 

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: const Offset(0, 2))
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                titulo,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF001a33)),
              ),
              Text(
                "${(porcentaje * 100).toInt()}%",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: colorBarra == Colors.tealAccent ? Colors.teal : Colors.deepPurple),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: porcentaje,
              minHeight: 12,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(colorBarra == Colors.tealAccent ? Colors.teal : colorBarra),
            ),
          ),
        ],
      ),
    );
  }

  Widget _botonMoradoEstiloImagen(String texto, VoidCallback accion) {
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

  // CONTROL DE FLUJO GENERAL (Arranca directo en la portada del Nivel 1)
  int _faseActual = 1;

  // ESTADOS INTERACTIVOS
  int _subPasoActual = 0;
  bool _actividadCompletada = false;
  List<Offset> _puntosTrazo = []; 
  List<String> _elementosSeleccionados = [];

  // ================= LISTAS DE RECURSOS EXACTOS =================
  final List<String> _vocales = ['A', 'E', 'I', 'O', 'U'];
  final List<String> _silabas = ['BI', 'BOL', 'DA', 'LA', 'LLE', 'MO', 'NE', 'NO', 'SI', 'TE'];

  final List<Map<String, String>> _palabrasNivel3 = [
    {'texto': 'HOLA', 'img': 'HOLA.png', 'def': 'LUMO_LECTURA definición de HOLA.png'},
    {'texto': 'BAJO', 'img': 'BAJO.png', 'def': 'LUMO_LECTURA definición de BAJO.png'},
    {'texto': 'PAGO', 'img': 'PAGO.png', 'def': 'LUMO_LECTURA definición de PAGO.png'},
    {'texto': 'MAS', 'img': 'MAS.png', 'def': 'LUMO_LECTURA definición de MÁS.png'},
    {'texto': 'BUSCO', 'img': 'BUSCO.png', 'def': 'LUMO_LECTURA definición de BUSCO.png'},
    {'texto': 'ALTO', 'img': 'ALTO.png', 'def': 'LUMO_LECTURA definición de ALTO.png'},
  ];

  final List<Map<String, dynamic>> _armarPalabrasNivel4 = [
    {'palabra': 'VENDE', 'def': 'LUMO_LECTURA definición de VENDE.png', 'correcta': ['VEN', 'DE'], 'opciones': ['DE', 'VEN', 'LA']},
    {'palabra': 'CAJA', 'def': 'LUMO_LECTURA definición de CAJA.png', 'correcta': ['CA', 'JA'], 'opciones': ['JA', 'CA', 'MO']},
    {'palabra': 'COMPRA', 'def': 'LUMO_LECTURA definición de COMPRA.png', 'correcta': ['COM', 'PRA'], 'opciones': ['PRA', 'TE', 'COM']},
    {'palabra': 'DINERO', 'def': 'LUMO_LECTURA definición de DINERO.png', 'correcta': ['DI', 'NE', 'RO'], 'opciones': ['NE', 'DI', 'RO']},
    {'palabra': 'BILLETE', 'def': 'LUMO_LECTURA definición de BILLETE.png', 'correcta': ['BI', 'LLE', 'TE'], 'opciones': ['TE', 'BI', 'LLE']},
    {'palabra': 'MONEDA', 'def': 'LUMO_LECTURA definición de MONEDA.png', 'correcta': ['MO', 'NE', 'DA'], 'opciones': ['DA', 'MO', 'NE']},
  ];

  final List<Map<String, dynamic>> _frasesNivel5 = [
    {
      'frase': 'PAGUÉ UNA CUENTA', 
      'correcta': ['PAGUÉ', 'UNA', 'CUENTA'], 
      'opciones': ['CUENTA', 'UNA', 'PAGUÉ', 'PASÉ', 'UN'],
      'def': 'LUMO_LECTURA definición de PAGUÉ UNA CUENTA.png'
    },
    {
      'frase': 'GASTÉ TRES BILLETES', 
      'correcta': ['GASTÉ', 'TRES', 'BILLETES'], 
      'opciones': ['BILLETES', 'CINCO', 'GASTÉ', 'TENGO', 'TRES'],
      'def': 'LUMO_LECTURA definición de GASTÉ TRES BILLETES.png'
    }
  ];

  final List<Map<String, String>> _palabrasOriginales = [
    {'palabra': 'AUTO', 'imagen': 'auto.png'},
    {'palabra': 'MANO', 'imagen': 'mano.png'},
    {'palabra': 'MESA', 'imagen': 'mesa.png'},
    {'palabra': 'GATO', 'imagen': 'gato.png'},
    {'palabra': 'PAN', 'imagen': 'pan.png'},
  ];

  Future<void> _hablar(String texto) async {
    await flutterTts.setLanguage("es-CL");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(texto);
  }

  void _cambiarFase(int nuevaFase) {
    setState(() {
      _faseActual = nuevaFase;
      _subPasoActual = 0;
      _actividadCompletada = false;
      _puntosTrazo.clear();
      _elementosSeleccionados.clear();
    });

    if (nuevaFase == 1) _hablar("Nivel 1: Reforcemos las vocales.");
    if (nuevaFase == 2) _hablar("Nivel 2: Revisemos algunas sílabas.");
    if (nuevaFase == 3) _hablar("Nivel 3: Revisemos algunas palabras.");
    if (nuevaFase == 4) _hablar("Nivel 4: Armemos algunas palabras.");
    if (nuevaFase == 5) _hablar("Nivel 5: Armemos algunas frases.");
    if (nuevaFase == 6) _hablar("Nivel 6: Practiquemos la lectura.");
  }

  @override
  void initState() {
    super.initState();
    _hablar("Bienvenido a Manty");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C5364), // Fondo base unificado
      body: Container(
        // FONDO LIMPIO CON DEGRADADO PROFESIONAL MANTY + ESTRELLAS
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2C5364), Color(0xFF203A43)],
          ),
          image: DecorationImage(
            image: AssetImage('assets/images/estrellas_fondo.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // CONTENIDO PRINCIPAL
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 110, left: 16, right: 16, top: 16),
                child: Center(
                  child: _buildContenidoFase(),
                ),
              ),
            ),

            // NAVEGACIÓN INFERIOR FIJA
            if (_faseActual != 1 && _faseActual != 2 && _faseActual != 3 && _faseActual != 4 && _faseActual != 5 && _faseActual != 6) 
              _buildBotonesNavegacionFijos(),
          ],
        ),
      ),
    );
  }

  Widget _buildContenidoFase() {
    switch (_faseActual) {
      case 1: return _buildPortadaNivelDinamica("Nivel 1:\nReforcemos\nlas vocales", 11);
      case 2: return _buildPortadaNivelDinamica("Nivel 2:\nRevisemos\nalgunas sílabas", 12);
      case 3: return _buildPortadaNivelDinamica("Nivel 3:\nRevisemos\nalgunas palabras", 13);
      case 4: return _buildPortadaNivelDinamica("Nivel 4:\nArmemos\nalgunas palabras", 14);
      case 5: return _buildPortadaNivelDinamica("Nivel 5:\nArmemos\nalgunas frases", 15);
      case 6: return _buildPortadaNivelDinamica("Nivel 6:\nPractiquemos\nla lectura", 16);
      case 11: return _buildRellenarVocales();
      case 12: return _buildRellenarSilabas();
      case 13: return _buildRellenarPalabrasNivel3();
      case 14: return _buildArmarPalabrasNivel4();
      case 15: return _buildArmarFrasesNivel5();
      case 155: return _buildExplicacionFraseNivel5();
      case 16: return _buildLecturaFinalNivel6();
      case 7: return _buildPantallaExitoFinal();
      default: return _buildRellenarVocales();
    }
  }

  // --- PORTADA DE NIVELES ---
  Widget _buildPortadaNivelDinamica(String textoBocadillo, int siguienteFase) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFE0),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.black.withOpacity(0.25), width: 2),
                  boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 8, offset: Offset(0, 4))],
                ),
                child: Text(
                  textoBocadillo,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B365D),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.asset(
                    'assets/images/lumo_asistente_base.png',
                    height: 220,
                    errorBuilder: (c, e, s) => const Icon(Icons.local_fire_department, size: 150, color: Colors.cyanAccent),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Icon(Icons.menu_book_rounded, size: 60, color: Colors.brown.shade200),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 280,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                  ),
                  onPressed: () => _cambiarFase(siguienteFase),
                  child: const Text(
                    "INICIAR LECCIÓN",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2C5364)),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          right: 10,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
            icon: const Icon(Icons.volume_up, color: Colors.black),
            label: const Text("Escuchar", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14)),
            onPressed: () => _hablar(textoBocadillo.replaceAll('\n', ' ')),
          ),
        ),
      ],
    );
  }

  // --- NIVEL 1: RELLENAR VOCALES ---
  Widget _buildRellenarVocales() {
    String vocal = _vocales[_subPasoActual];
    return Column(
      children: [
        Image.asset('assets/images/LUMO_LECTURA Escucha the vocal.png', height: 75, errorBuilder: (c,e,s) => const SizedBox.shrink()),
        Expanded(
          child: GestureDetector(
            onPanUpdate: (d) {
              RenderBox box = context.findRenderObject() as RenderBox;
              setState(() {
                _puntosTrazo.add(box.globalToLocal(d.globalPosition));
                if (_puntosTrazo.length > 12) _actividadCompletada = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/$vocal.png', 
                  fit: BoxFit.contain, 
                  color: Colors.white.withOpacity(0.25),
                  colorBlendMode: BlendMode.modulate,
                  errorBuilder: (c,e,s) => Text(vocal, style: const TextStyle(fontSize: 150, color: Colors.white24, fontWeight: FontWeight.bold)),
                ),
                CustomPaint(painter: DibujoDedoPainter(_puntosTrazo), child: Container()),
              ],
            ),
          ),
        ),
        _buildBotonSiguienteValidado(
          condicion: _actividadCompletada,
          msgBloqueo: "No podrá avanzar hasta rellenar la vocal",
          onTap: () {
            if (_subPasoActual < _vocales.length - 1) {
              setState(() { _subPasoActual++; _actividadCompletada = false; _puntosTrazo.clear(); });
            } else {
              _cambiarFase(2);
            }
          },
        ),
      ],
    );
  }

  // --- NIVEL 2: RELLENAR SÍLABAS ---
  Widget _buildRellenarSilabas() {
    String silaba = _silabas[_subPasoActual];
    return Column(
      children: [
        Image.asset('assets/images/LUMO_LECTURA escucha la sílaba.png', height: 75, errorBuilder: (c,e,s) => const SizedBox.shrink()),
        Expanded(
          child: GestureDetector(
            onPanUpdate: (d) {
              RenderBox box = context.findRenderObject() as RenderBox;
              setState(() {
                _puntosTrazo.add(box.globalToLocal(d.globalPosition));
                if (_puntosTrazo.length > 12) _actividadCompletada = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/$silaba.png', 
                  fit: BoxFit.contain, 
                  color: Colors.white.withOpacity(0.25),
                  colorBlendMode: BlendMode.modulate,
                  errorBuilder: (c,e,s) => Text(silaba, style: const TextStyle(fontSize: 100, color: Colors.white24, fontWeight: FontWeight.bold)),
                ),
                CustomPaint(painter: DibujoDedoPainter(_puntosTrazo), child: Container()),
              ],
            ),
          ),
        ),
        _buildBotonSiguienteValidado(
          condicion: _actividadCompletada,
          msgBloqueo: "No podrá avanzar hasta rellenar la sílaba",
          onTap: () {
            if (_subPasoActual < _silabas.length - 1) {
              setState(() { _subPasoActual++; _actividadCompletada = false; _puntosTrazo.clear(); });
            } else {
              _cambiarFase(3);
            }
          },
        ),
      ],
    );
  }

  // --- NIVEL 3: RELLENAR PALABRA ---
  Widget _buildRellenarPalabrasNivel3() {
    var item = _palabrasNivel3[_subPasoActual];
    return Column(
      children: [
        Image.asset('assets/images/LUMO_LECTURA escucha la palabra.png', height: 75, errorBuilder: (c,e,s) => const SizedBox.shrink()),
        Expanded(
          child: GestureDetector(
            onPanUpdate: (d) {
              RenderBox box = context.findRenderObject() as RenderBox;
              setState(() {
                _puntosTrazo.add(box.globalToLocal(d.globalPosition));
                if (_puntosTrazo.length > 12) _actividadCompletada = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/${item['img']}', 
                  fit: BoxFit.contain, 
                  color: Colors.white.withOpacity(0.25),
                  colorBlendMode: BlendMode.modulate,
                  errorBuilder: (c,e,s) => Text(item['texto']!, style: const TextStyle(fontSize: 80, color: Colors.white24, fontWeight: FontWeight.bold)),
                ),
                CustomPaint(painter: DibujoDedoPainter(_puntosTrazo), child: Container()),
              ],
            ),
          ),
        ),
        _buildBotonSiguienteValidado(
          condicion: _actividadCompletada,
          msgBloqueo: "No podrá avanzar hasta rellenar la palabra",
          onTap: () {
            if (_subPasoActual < _palabrasNivel3.length - 1) {
              setState(() { _subPasoActual++; _actividadCompletada = false; _puntosTrazo.clear(); });
            } else {
              _cambiarFase(4);
            }
          },
        ),
      ],
    );
  }

  // --- NIVEL 4: ARMAR PALABRAS ---
  Widget _buildArmarPalabrasNivel4() {
    var item = _armarPalabrasNivel4[_subPasoActual];
    List<String> opciones = List<String>.from(item['opciones']);
    List<String> correcta = List<String>.from(item['correcta']);

    bool ok = _elementosSeleccionados.length == correcta.length &&
        _elementosSeleccionados.asMap().entries.every((e) => correcta[e.key] == e.value);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/LUMO_LECTURA arma la palabra.png', height: 60, errorBuilder: (c,e,s) => const SizedBox.shrink()),
        const SizedBox(height: 10),
        Container(
          height: 140,
          padding: const EdgeInsets.all(8),
          child: Image.asset('assets/images/${item['def']}', fit: BoxFit.contain, errorBuilder: (c,e,s) => Text(item['palabra'], style: const TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold))),
        ),
        const SizedBox(height: 20),
        DragTarget<String>(
          builder: (context, c, r) => Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            decoration: BoxDecoration(
              color: ok ? Colors.green.withOpacity(0.2) : Colors.white.withOpacity(0.1), 
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: ok ? Colors.green : Colors.white24, width: 2)
            ),
            child: _elementosSeleccionados.isEmpty
                ? const SizedBox(height: 50, child: Center(child: Text("Arrastra las sílabas aquí en orden", style: TextStyle(color: Colors.white54, fontSize: 16))))
                : Wrap(
                    alignment: WrapAlignment.center, 
                    spacing: 12,
                    children: _elementosSeleccionados.map((s) => InputChip(
                      label: Text(s, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), 
                      onDeleted: () => setState(() => _elementosSeleccionados.remove(s))
                    )).toList()
                  ),
          ),
          onAcceptWithDetails: (d) { 
            if (!_elementosSeleccionados.contains(d.data) && _elementosSeleccionados.length < correcta.length) {
              setState(() => _elementosSeleccionados.add(d.data)); 
            }
          },
        ),
        const SizedBox(height: 25),
        Wrap(
          spacing: 15,
          runSpacing: 10,
          children: opciones.map((s) => Draggable<String>(
            data: s,
            feedback: Material(color: Colors.transparent, child: Chip(label: Text(s, style: const TextStyle(fontSize: 18)))),
            child: Opacity(
              opacity: _elementosSeleccionados.contains(s) ? 0.3 : 1.0, 
              child: ActionChip(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                label: Text(s, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), 
                onPressed: () { 
                  if (!_elementosSeleccionados.contains(s) && _elementosSeleccionados.length < correcta.length) {
                    setState(() => _elementosSeleccionados.add(s)); 
                  }
                }
              )
            ),
          )).toList(),
        ),
        const Spacer(),
        _buildBotonSiguienteValidado(
          condicion: ok,
          msgBloqueo: "No podrá avanzar hasta armar la palabra correctamente",
          onTap: () {
            if (_subPasoActual < _armarPalabrasNivel4.length - 1) {
              setState(() { _subPasoActual++; _elementosSeleccionados.clear(); });
            } else {
              _cambiarFase(5);
            }
          },
        ),
      ],
    );
  }

  // --- NIVEL 5 PARTE 1: ARMAR FRASES ---
  Widget _buildArmarFrasesNivel5() {
    var item = _frasesNivel5[_subPasoActual];
    List<String> opciones = List<String>.from(item['opciones']);
    List<String> correcta = List<String>.from(item['correcta']);

    bool ok = _elementosSeleccionados.length == correcta.length &&
        _elementosSeleccionados.asMap().entries.every((e) => correcta[e.key] == e.value);

    return Column(
      children: [
        Image.asset('assets/images/LUMO_LECTURA arma la frase.png', height: 75, errorBuilder: (c,e,s) => const SizedBox.shrink()),
        const SizedBox(height: 20),
        DragTarget<String>(
          builder: (context, c, r) => Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 80),
            decoration: BoxDecoration(color: ok ? Colors.green.withOpacity(0.15) : Colors.white10, borderRadius: BorderRadius.circular(15)),
            child: _elementosSeleccionados.isEmpty
                ? const Center(child: Text("Suelte las palabras en orden", style: TextStyle(color: Colors.white30)))
                : Wrap(alignment: WrapAlignment.center, children: _elementosSeleccionados.map((p) => InputChip(label: Text(p), onDeleted: () => setState(() => _elementosSeleccionados.remove(p)))).toList()),
          ),
          onAcceptWithDetails: (d) { if (!_elementosSeleccionados.contains(d.data) && _elementosSeleccionados.length < correcta.length) setState(() => _elementosSeleccionados.add(d.data)); },
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10,
          children: opciones.map((p) => Draggable<String>(
            data: p,
            feedback: Material(color: Colors.transparent, child: Chip(label: Text(p))),
            child: Opacity(opacity: _elementosSeleccionados.contains(p) ? 0.3 : 1.0, child: ActionChip(label: Text(p), onPressed: () { if (_elementosSeleccionados.length < correcta.length) setState(() => _elementosSeleccionados.add(p)); })),
          )).toList(),
        ),
        const Spacer(),
        _buildBotonSiguienteValidado(
          condicion: ok,
          msgBloqueo: "No podrá avanzar hasta completar la frase",
          onTap: () {
            setState(() { _faseActual = 155; });
          },
        ),
      ],
    );
  }

  // --- NIVEL 5 PARTE 2: EXPLICACIÓN DE LA ORACIÓN ---
  Widget _buildExplicacionFraseNivel5() {
    var item = _frasesNivel5[_subPasoActual];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Significado de la oración:", style: TextStyle(color: Colors.white70, fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        Expanded(
          child: Image.asset(
            'assets/images/${item['def']}',
            fit: BoxFit.contain,
            errorBuilder: (c, e, s) => Center(child: Text('[Explicación Oración: ${item['frase']}]', style: const TextStyle(color: Colors.tealAccent, fontSize: 18, fontWeight: FontWeight.bold))),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 200,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            onPressed: () {
              if (_subPasoActual < _frasesNivel5.length - 1) {
                setState(() { _subPasoActual++; _elementosSeleccionados.clear(); _faseActual = 15; });
              } else {
                _cambiarFase(6);
              }
            },
            child: const Text("ENTENDIDO", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ),
      ],
    );
  }

  // --- NIVEL 6: LISTA ORIGINAL ---
  Widget _buildLecturaFinalNivel6() {
    final item = _palabrasOriginales[_subPasoActual];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/lumo_asistente_base.png', height: 75, errorBuilder: (c,e,s) => const Icon(Icons.face, size: 50, color: Colors.white24)),
        Expanded(child: Image.asset('assets/images/${item['imagen']}', fit: BoxFit.contain, errorBuilder: (c,e,s) => const Icon(Icons.image, size: 80, color: Colors.white24))),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Text(item['palabra']!, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1F3C4D))),
              const Divider(),
              Text(item['palabra']!.split('').join(' '), style: const TextStyle(fontSize: 22, color: Colors.orange, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: 200,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            onPressed: () {
              if (_subPasoActual < _palabrasOriginales.length - 1) {
                setState(() => _subPasoActual++);
              } else {
                _cambiarFase(7);
              }
            },
            child: const Text("SIGUIENTE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildPantallaExitoFinal() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.check_circle, size: 90, color: Colors.greenAccent),
        const SizedBox(height: 20),
        const Text("¡Gran trabajo!", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
          onPressed: () => _cambiarFase(1), // Retorna directo al Nivel 1
          child: const Text("VOLVER AL INICIO", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  // --- BOTONES AUXILIARES DE VALIDACIÓN ---
  Widget _buildBotonSiguienteValidado({required bool condicion, required String msgBloqueo, required VoidCallback onTap}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 220,
          height: 50,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: condicion ? Colors.white : Colors.white10, 
              foregroundColor: condicion ? const Color(0xFF1F3C4D) : Colors.white24,
            ),
            icon: const Icon(Icons.arrow_forward),
            label: const Text("SIGUIENTE", style: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: condicion ? onTap : () => _hablar(msgBloqueo),
          ),
        ),
        if (!condicion) Padding(padding: const EdgeInsets.only(top: 6), child: Text(msgBloqueo, style: const TextStyle(color: Colors.orangeAccent, fontSize: 12))),
      ],
    );
  }

  Widget _buildBotonesNavegacionFijos() {
    return Positioned(
      bottom: 25,
      left: 20,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 130,
            height: 55,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
              icon: const Icon(Icons.arrow_back),
              label: const Text("Volver"),
              onPressed: () {
                if (_faseActual == 155) {
                  setState(() { _faseActual = 15; });
                } else if (_faseActual > 10) {
                  _cambiarFase(_faseActual - 10);
                } else {
                  _cambiarFase(_faseActual - 1);
                }
              },
            ),
          ),
          SizedBox(
            width: 130,
            height: 55,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
              icon: const Icon(Icons.volume_up),
              label: const Text("Escuchar"),
              onPressed: () {
                if (_faseActual == 11) _hablar(_vocales[_subPasoActual]);
                if (_faseActual == 12) _hablar(_silabas[_subPasoActual]);
                if (_faseActual == 13) _hablar(_palabrasNivel3[_subPasoActual]['texto']!);
                if (_faseActual == 14) _hablar(_armarPalabrasNivel4[_subPasoActual]['palabra']!);
                if (_faseActual == 15) _hablar(_frasesNivel5[_subPasoActual]['frase']!);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DibujoDedoPainter extends CustomPainter {
  final List<Offset> points;
  DibujoDedoPainter(this.points);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.tealAccent..strokeCap = StrokeCap.round..strokeWidth = 14.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != Offset.zero && points[i + 1] != Offset.zero) canvas.drawLine(points[i], points[i + 1], paint);
    }
  }
  @override
  bool shouldRepaint(covariant DibujoDedoPainter old) => old.points != points;
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
