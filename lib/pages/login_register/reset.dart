import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);
  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding:
            const EdgeInsets.only(left: 25.0, right: 25.0, top: 15, bottom: 25),
        child: TextField(
          controller: emailController,
          obscureText: true,
          decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
              labelText: 'Email',
              hintText: 'Email'),
        ),
      ),
      TextButton(
        style: TextButton.styleFrom(primary: Colors.green),
        onPressed: () => {
          if (emailController.text.isNotEmpty)
            {
              auth.sendPasswordResetEmail(email: emailController.text),
              Navigator.pop(context, 'Reset password')
            }
          else
            {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Container(
                    height: 90,
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ),
                    child: const Text('Entrez une adresse email valide'),
                  ),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  )),
                
              Navigator.pop(context, 'Reset password')
            }
        },
        child: const Text('OK'),
      ),
    ]);
  }
}
