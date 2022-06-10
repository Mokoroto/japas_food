import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MenuView extends StatefulWidget {
  const MenuView({Key? key}) : super(key: key);

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
    FirebaseAuth auth = FirebaseAuth.instance;
    
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                Color.fromARGB(255, 245, 233, 66),
                Color.fromARGB(22, 63, 226, 255),
              ],
            ),
          ),
          width: double.infinity,
          height: double.infinity,
          child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Image.asset('images/LOGO.png'),
              Scaffold(
                floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.logout),
                  onPressed: (){
                    auth.signOut();
                    Navigator.of(context).pushReplacementNamed('/');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}