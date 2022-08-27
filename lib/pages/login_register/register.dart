import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final fb = FirebaseDatabase.instance;

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

  Future signUp() async {
    final ref = fb.ref().child('users');
    var id = 0;

    ref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as List;
      id = data.length+1;
    });
    var ref2 = fb.ref().child('users/');

    if (passwordController.text != confirmPasswordController.text) {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                  title: const Text("Les mots de passe ne correspondent pas"),
                  actions: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(primary: Colors.purple),
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ]));
    } else {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());

        Navigator.pop(context);
        ref2.push().set({ id : emailController.text.trim()});
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
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.only(
                  left: 25.0, right: 25.0, top: 25, bottom: 25),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 25.0, right: 25.0, top: 15, bottom: 25),
              //padding: EdgeInsets.symmetric(horizontal: 15),
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
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Confirm Password',
                    hintText: ''),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 25.0, right: 25.0, top: 15, bottom: 15),
              child: SizedBox(
                height: 50,
                width: 250,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    signUp();
                  },
                  child: const Text(
                    "S'inscrire",
                    style: TextStyle(color: Colors.purple, fontSize: 25),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 25.0, right: 25.0, top: 35, bottom: 25),
              child: SizedBox(
                height: 40,
                width: 300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Déjà membre ?',
                    style: TextStyle(color: Colors.purple, fontSize: 20),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
