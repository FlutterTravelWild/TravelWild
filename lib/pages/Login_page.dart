import 'package:flutter/material.dart';
import 'package:fluttertravelwild/data/firebase_api.dart';
// import 'package:fluttertravelwild/pages/HomePage.dart';
import 'package:fluttertravelwild/pages/profile_page.dart';
import 'package:fluttertravelwild/pages/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import '../models/User.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  late bool _passwordVisible;
  User Userload = User.Empty();
  final FirebaseApi _firebaseApi = FirebaseApi();
  @override
  void initState() {
    _passwordVisible = false;
    // _getUser();
    super.initState();
  }

  // @override
  // void initState() {
  //   _getUser();
  //   super.initState();
  // }
  void _showMsg(String msg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Msg',
        onPressed: scaffold.hideCurrentSnackBar,
      ),
    ));
  }

  // void _validateUser() {
  //   print("validate");
  //   print("user email ${Userload.email}");
  //   print("input email ${_email.text}");
  //   print("User password ${Userload.password}");
  //   print("inpur password ${_password.text}");
  //   print("final");

  //   if (_email.text == Userload.email && _password.text == Userload.password) {
  //     print("hola");
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => const HomePage()));
  //   } else {
  //     //  Userload._showMsg("Contraseña invalida");
  //     print("object");
  //     _showMsg("Email or password incorrect");
  //   }
  // }
  void _validateUser() async {
    if (_email.text.isEmpty || _password.text.isEmpty) {
      _showMsg("Emply values");
    } else {
      var result = await _firebaseApi.logInUser(_email.text, _password.text);
      String msg = "";

      if (result == "invalid-email") {
        msg = "invalid-email";
      } else if (result == "weak-password") {
        msg = "weak-password min 6 digit";
      } else if (result == "network-request-failed") {
        msg = "not connection a network";
      } else if (result == "user-not-found") {
        msg = "user-not-found";
      } else if (result == "unknown") {
        msg = "user-not-found";
      } else {
        msg = "connection success";
        print("entro");
        print(result);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ProfilePage()));
      }
      _showMsg(msg);
    }
  }

  void _togglePasswordView() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  _getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userMap =
        jsonDecode(prefs.getString("user")!); // ! quita null
    // userLoad = "f" as User;
    Userload = User.fromJson(userMap);
  }

  @override
  Widget build(BuildContext context) {
    final logo = Image(
      image: AssetImage('assets/img/baggage.png'),
      width: 300,
      height: 150,
    );

    final emailL = TextFormField(
      controller: _email,
      decoration: const InputDecoration(
        icon: Icon(Icons.email),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(80.0))),
        labelText: 'Email',
      ),
      // obscureText: true,
      keyboardType: TextInputType.emailAddress,
    );

    final passwordL = TextField(
        controller: _password,
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock_open_outlined),
          border: OutlineInputBorder(
              borderRadius:
                  const BorderRadius.all(const Radius.circular(80.0))),
          hintText: 'Password',
          // suffix: InkWell(
          //   onTap: _togglePasswordView,
          //   child: Icon(
          //     _passwordVisible ? Icons.visibility_off : Icons.visibility,
          //   ),
          // ),
        ));

    final loginBtn = ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          // side: BorderSide(color: Colors.red)
        ))),
        onPressed: () {
          _validateUser();
          // print("login");
        },
        child: const Text("Iniciar sesion"));

    final regisBtn = ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          // side: BorderSide(color: Colors.red)
        ))),
        onPressed: () {
          // _validateUser();

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => RegisterPage()));
        },
        child: const Text("Registrarse"));
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              logo,
              const SizedBox(
                height: 100,
              ),

              emailL,
              const SizedBox(
                height: 20,
              ),
              passwordL,
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [loginBtn, regisBtn],
              )

              // contrasena,
              // pass
            ],
          ),
        )),
      ),
    );
  }
}
