import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertravelwild/pages/HomePage.dart';
import 'package:fluttertravelwild/pages/Login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Mi perfil")),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Body(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
          child: const Icon(
            Icons.navigate_next,
            color: Colors.white,
          )),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Usar aqui datos reales del usuario.
    var currentUser = FirebaseAuth.instance.currentUser;
    String userName = "Adriana Lucia Cadavid";
    String tipoSangre = "A+";
    String email = currentUser?.email ?? "Sin email";
    String fechaNacimiento = "01/10/1979";
    List<String> preferencias = [
      "Cultural",
      "Religiosa",
      "Cultural",
      "Religiosa",
      "Cultural",
      "Religiosa",
      "Cultural",
      "Religiosa"
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            child: Saludo(
              nombre: userName,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            child: Datos(
              tipoSangre: tipoSangre,
              email: email,
              fechaNacimiento: fechaNacimiento,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            child: Preferencias(
              preferencias: preferencias,
            ),
          ),
        ],
      ),
    );
  }
}

class Saludo extends StatelessWidget {
  final String nombre;
  const Saludo({Key? key, required String this.nombre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("Bienvenido", style: TextStyle(fontSize: 20)),
          Container(
            child: Image.asset('assets/img/usuario.png'),
            height: 200,
          ),
          AppText(
            text: nombre,
          )
        ],
      ),
    );
  }
}

class Datos extends StatelessWidget {
  final String tipoSangre;
  final String email;
  final String fechaNacimiento;
  const Datos(
      {Key? key,
      required this.tipoSangre,
      required this.email,
      required this.fechaNacimiento})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Tus datos son:", style: TextStyle(fontSize: 20)),
        DatosItem(
          icon: Icons.bloodtype,
          iconColor: Colors.cyan,
          textData: "Tipo de sangre: $tipoSangre",
        ),
        DatosItem(
            textData: "Email: $email",
            icon: Icons.email_outlined,
            iconColor: Colors.cyan),
        DatosItem(
            textData: "Fecha de nacimiento : $fechaNacimiento",
            icon: Icons.date_range_outlined,
            iconColor: Colors.cyan),
      ],
    );
  }
}

//Icon(, color: Colors.red,)
class DatosItem extends StatelessWidget {
  final String textData;
  final IconData icon;
  final Color iconColor;
  const DatosItem(
      {Key? key,
      required this.textData,
      required this.icon,
      required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10),
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor,
          ),
          const SizedBox(width: 10),
          AppText(text: textData),
        ],
      ),
    );
  }
}

class Preferencias extends StatelessWidget {
  final List<String> preferencias;
  const Preferencias({Key? key, required this.preferencias}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> preferenciasWidgets = [];

    preferencias.forEach((element) {
      preferenciasWidgets.add(PreferenciasLabel(
        preferencia: element,
      ));
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tus preferencias turisticas",
          style: TextStyle(fontSize: 20),
        ),
        ...preferenciasWidgets
      ],
    );
  }
}

class PreferenciasLabel extends StatelessWidget {
  final String preferencia;
  const PreferenciasLabel({super.key, required this.preferencia});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Colors.cyan,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      margin: const EdgeInsets.only(top: 10, left: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star_border,
            color: Colors.white,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            preferencia,
            style: const TextStyle(fontSize: 15, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class AppText extends StatelessWidget {
  final String text;
  const AppText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 15, color: Colors.black),
    );
  }
}
