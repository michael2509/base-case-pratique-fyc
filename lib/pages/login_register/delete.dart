import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class DeleteUser extends StatefulWidget {
  const DeleteUser({Key? key}) : super(key: key);

  @override
  State<DeleteUser> createState() => _DeleteUserState();
}

class _DeleteUserState extends State<DeleteUser> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding:
            const EdgeInsets.only(left: 25.0, right: 25.0, top: 15, bottom: 25),
        child: TextField(
          controller: emailController,
          decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
              labelText: 'Email',
              hintText: 'Email'),
        ),
      ),
      Padding(
        padding:
            const EdgeInsets.only(left: 25.0, right: 25.0, top: 15, bottom: 25),
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
      TextButton(
        style: TextButton.styleFrom(primary: Colors.green),
        onPressed: () async => {
          //auth.sendPasswordResetEmail(email: emailController.text),
          //Navigator.pop(context, 'Delete account')
          if (emailController.text.isNotEmpty &&
              emailController.text.contains('@') &&
              emailController.text.contains('@'))
            {
              //auth.sendPasswordResetEmail(email: emailController.text),
              await auth
                  .signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text)
                  .then((user) => auth.currentUser?.delete())
                  .then((value) => auth.signOut())
                  .then(
                    (user) =>
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Container(
                        height: 90,
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green,
                        ),
                        child: const Text('Compte supprimé'),
                      ),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                    )),
                  )
                  .catchError((error) => print(error)),
              Navigator.pop(context, 'Delete account')
            }
          else
            {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Container(
                  height: 90,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red,
                  ),
                  child: const Text('Entrez des identifiants valides'),
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
              )),
              Navigator.pop(context, 'Delete account')
            }
        },
        child: const Text('OK'),
      ),
    ]);
  }
}
