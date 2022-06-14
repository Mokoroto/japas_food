import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:japas_food/View/perfil.view.dart';


import 'cadastro.view.dart';
import 'login.view.dart';
import 'menu.view.dart';
import 'perfil.view.dart';


class App extends StatelessWidget {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => LoginView(),
        '/perfil': (context) => PerfilView(),
        '/cadastro': (context) => CadastroView(),
        '/menu': (context) => MenuView(),
      },
      initialRoute: auth.currentUser == null ? '/' : '/menu'
    );
  }
}