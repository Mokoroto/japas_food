import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:japas_food/View/perfil.view.dart';


import 'logar.view.dart';
import 'login.view.dart';


class App extends StatelessWidget {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      routes: {
        '/': (context) => LogarView(),
        '/perfil': (context) => PerfilView(),
        //'/register': (context) => RegisterView(),
        //'/conversa': (context) => ChatView()
      },
      initialRoute: auth.currentUser == null ? '/' : '/login'
    );
  }
}