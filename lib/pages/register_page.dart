import 'package:flutter/material.dart';

import 'package:fluttertravelwild/data/firebase_api.dart';
import 'package:intl/intl.dart';
import 'package:fluttertravelwild/pages/login_page.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
import '../models/User.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

enum Genre { M, F }

class _RegisterPageState extends State<RegisterPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _reppassword = TextEditingController();
  final _name = TextEditingController();
  final _typeS = TextEditingController();
  String _date = "";
  String _data = "";
  Genre? _genre = Genre.M;
  late bool _passwordVisible;

  bool _cultural = false;
  bool _religioso = false;
  bool _gastronomico = false;
  bool _deportivo = false;
  bool _parquestematicos = false;
  bool _aventura = false;
  String buttonMsg = "Fecha de nacimiento";

  final FirebaseApi _firebaseApi = FirebaseApi();
  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  void _showMsg(String msg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Msg: ',
        onPressed: scaffold.hideCurrentSnackBar,
      ),
    ));
  }

  void _togglePasswordView() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  String _dateConverter(DateTime newDate) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String dateFormatted = formatter.format(newDate);
    return dateFormatted;
  }

  void _showSelectDate() async {
    final DateTime? newDate = await showDatePicker(
        context: context,
        locale: const Locale('es', 'CO'),
        initialDate: DateTime(2022, 8),
        firstDate: DateTime(1900, 1),
        lastDate: DateTime(2022, 12),
        helpText: "Fecha de nacimiento");

    if (newDate != null) {
      setState(() {
        _date = _dateConverter(newDate);
        buttonMsg = "fecha: ${_date.toString()}";
      });
    }
  }

  void _saveUser(User user) async {
    var result = await _firebaseApi.createUser(user);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void _registerUser(User user) async {
    //  local store
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString("user", jsonEncode(user));
    // // print("SaveUser");
    // String json = jsonEncode(user);

    // print(json);
    // Firebase
    var result = await _firebaseApi.registerUser(user.email, user.password);
    String msg = "";
    if (result == "invalid-email") {
      msg = "invalid-email";
    } else if (result == "weak-password") {
      msg = "weak-password min 6 digit";
    } else if (result == "email-already-in-use") {
      msg = "email in use";
    } else if (result == "network-request-failed") {
      msg = "not connection a network";
    } else {
      msg = " success";
      // print(result);
      user.uid = result;
      _saveUser(user);
    }
    _showMsg(msg);
  }

  void _onRegisterButtonClicked() {
    setState(() {
      if (_password.text == _reppassword.text) {
        String genre = "M";
        String Turismo = '';

        if (_genre == Genre.F) {
          genre = 'F';
        }

        if (_aventura) Turismo = "$Turismo aventura";
        if (_religioso) Turismo = "$Turismo religioso";
        if (_deportivo) Turismo = "$Turismo deportivo";
        if (_cultural) Turismo = "$Turismo cultural";
        if (_parquestematicos) Turismo = "$Turismo parques";
        if (_gastronomico) Turismo = "$Turismo gastrónomico";

        // _data =    "Nombre: ${_name.text} \n Email: ${_email.text} \n Genere: ${genre}\n Genere Favo:${Turismo}\n naci: ${_date}";
        // _data =User(_name.text, _date, _email.text, Turismo, genre, _password.text);
        _data =
            "Nombre: ${_name.text}\n Sangre: ${_typeS.text} \n Email: ${_email.text} \n Genere: ${genre}\n TIpo de turismo:${Turismo}\n Fecha: ${_date} \n Password: ${_password.text}";
        var user = User("", _name.text, _typeS.text, genre, _date, _email.text,Turismo,
            _password.text);
        print(_data);

        // saveUser(user);
        _registerUser(user);
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => LoginPage()));

      } else {
        // print("object");
        _showMsg("Las contreñas deben ser iguales");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final logo = Image(
      image: AssetImage('assets/img/baggage.png'),
      width: 300,
      height: 150,
    );

    final emailR = TextFormField(
        controller: _email,
        decoration: const InputDecoration(
          icon: Icon(Icons.email),
          border: OutlineInputBorder(
              borderRadius:
                  const BorderRadius.all(const Radius.circular(80.0))),
          labelText: 'Email',
        ));

    final typeSF = TextFormField(
      controller: _typeS,
      decoration: const InputDecoration(
        icon: Icon(Icons.bloodtype_outlined),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(80.0))),
        labelText: 'Grupo sanguineo',
      ),
      // obscureText: true,
      keyboardType: TextInputType.emailAddress,
    );
    final nameR = TextFormField(
      controller: _name,
      decoration: const InputDecoration(
        icon: Icon(Icons.person),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(80.0))),
        labelText: 'Nombre',
      ),
      // obscureText: true,
      keyboardType: TextInputType.emailAddress,
    );

    final passwordR = TextFormField(
        controller: _password,
        keyboardType: TextInputType.visiblePassword,
        obscureText: _passwordVisible,
        decoration: InputDecoration(
          icon: Icon(Icons.lock_open_outlined),
          border: OutlineInputBorder(
              borderRadius:
                  const BorderRadius.all(const Radius.circular(80.0))),
          hintText: 'Password',
          suffix: InkWell(
            onTap: _togglePasswordView,
            child: Icon(
              _passwordVisible ? Icons.visibility_off : Icons.visibility,
            ),
          ),
        ));

    final repasswordR = TextFormField(
        controller: _reppassword,
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock_outline),
          border: OutlineInputBorder(
              borderRadius:
                  const BorderRadius.all(const Radius.circular(80.0))),
          hintText: 'Password repeat',
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
          // _validateUser();

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
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
          _onRegisterButtonClicked();
        },
        child: const Text("Registrarse"));

    final male = Expanded(
      child: ListTile(
        title: const Text('M'),
        leading: Radio<Genre>(
          value: Genre.M,
          groupValue: _genre,
          onChanged: (Genre? value) {
            setState(() {
              _genre = value;
            });
          },
        ),
      ),
    );

    final female = Expanded(
      child: ListTile(
        title: const Text('F'),
        leading: Radio<Genre>(
          value: Genre.F,
          groupValue: _genre,
          onChanged: (Genre? value) {
            setState(() {
              _genre = value;
            });
          },
        ),
      ),
    );

    final avent = CheckboxListTile(
        title: const Text("Aventura"),
        value: _aventura,
        selected: _aventura,
        onChanged: ((bool? value) {
          setState(() {
            _aventura = value!;
          });
        }));
    final cult = CheckboxListTile(
        title: const Text("Cultural"),
        value: _cultural,
        selected: _cultural,
        onChanged: ((bool? value) {
          setState(() {
            _cultural = value!;
          });
        }));
    final dep = CheckboxListTile(
        title: const Text("Deportivo"),
        value: _deportivo,
        selected: _deportivo,
        onChanged: ((bool? value) {
          setState(() {
            _deportivo = value!;
          });
        }));

    final gast = CheckboxListTile(
        title: const Text("Gastronómico"),
        value: _gastronomico,
        selected: _gastronomico,
        onChanged: ((bool? value) {
          setState(() {
            _gastronomico = value!;
          });
        }));
    final parq = CheckboxListTile(
        title: const Text("Parques"),
        value: _parquestematicos,
        selected: _parquestematicos,
        onChanged: ((bool? value) {
          setState(() {
            _parquestematicos = value!;
          });
        }));

    final rel = CheckboxListTile(
        title: const Text("Religioso"),
        value: _religioso,
        selected: _religioso,
        onChanged: ((bool? value) {
          setState(() {
            _religioso = value!;
          });
        }));

    final dateF = ElevatedButton(
      style: TextButton.styleFrom(textStyle: const TextStyle(fontSize: 16)),
      onPressed: () {
        _showSelectDate();
      },
      child: Text(buttonMsg),
    );

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
              nameR,
              const SizedBox(
                height: 20,
              ),
              typeSF,
              const SizedBox(
                height: 20,
              ),
              const Text("Fecha de nacimiento"),
              dateF,
              const Text("Genero"),
              Row(children: [male, female]),
              const Text("Turismo"),
              rel,
              gast,
              cult,
              dep,
              avent,
              parq,
              const SizedBox(
                height: 20,
              ),
              emailR,
              const SizedBox(
                height: 20,
              ),
              passwordR,
              const SizedBox(
                height: 20,
              ),
              repasswordR,
              const SizedBox(
                height: 20,
              ),
              regisBtn,
              loginBtn
            ],
          ),
        )),
      ),
    );
  }
}
