import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login_register/delete.dart';
import 'package:flutter_application_1/pages/login_register/register.dart';
import 'package:flutter_application_1/pages/login_register/reset.dart';
import '../home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _validate = false;

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      if (emailController.text.trim().isEmpty) {
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                    title: const Text("Le champ email ne peut être vide"),
                    actions: <Widget>[
                      TextButton(
                        style: TextButton.styleFrom(primary: Colors.purple),
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ]));
      } else {
        showDialog<String>(
            context: context,
            builder: (BuildContext context) =>
                AlertDialog(title: Text(e.toString()), actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(primary: Colors.green),
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ]));
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 180.0),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 25.0, right: 25.0, top: 25, bottom: 25),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Enter valid email id as abc@gmail.com',
                  //errorText: _validate ? 'Value Can\'t Be Empty' : null,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 25.0, right: 25.0, top: 15, bottom: 25),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                    left: 25.0, right: 25.0, top: 15, bottom: 25),
                child: SizedBox(
                  height: 50,
                  width: 220,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      //fixedSize: const Size(70, 70),
                    ),
                    onPressed: () {
                      signIn();
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.purple, fontSize: 25),
                    ),
                  ),
                )),
            SizedBox(
              height: 40,
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Register()));
                },
                child: const Text(
                  "Pas de compte ?   Inscris toi !",
                  style: TextStyle(color: Colors.purple, fontSize: 17),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            GestureDetector(
              onDoubleTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => const AlertDialog(
                          title: Text("Reset le mot de passe"),
                          actions: <Widget>[
                            ResetPassword(),
                          ])),
              onTap: () {
                print("Mot de passe oublié");
              },
              child: const Text(
                'Mot de passe oublié ?',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onDoubleTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => const AlertDialog(
                          title: Text("formulaire suppression compte"),
                          actions: <Widget>[
                            DeleteUser(),
                          ])),
              onTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => const AlertDialog(
                          title: Text("formulaire suppression compte"),
                          actions: <Widget>[
                            DeleteUser(),
                          ])),
              child: const Text(
                'Supprimer ton compte ? 😔',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
