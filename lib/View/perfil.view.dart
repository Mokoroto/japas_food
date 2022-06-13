import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class PerfilView extends StatefulWidget {
  const PerfilView({Key? key}) : super(key: key);

  @override
  State<PerfilView> createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {
  String nome = '';
  String email = '';
  String telefone = '';
  
  int _selectedIndex = 1;
  void carregausuario()async{
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;
    var user = auth.currentUser!;
    var usuario = await db.collection('usuarios').doc(user.uid).get();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
             label: 'Cardápio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_sharp),
             label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_home_sharp),
             label: 'Endereco',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
             label: 'Sair',
          ),
        ],
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.amber[900],
        selectedFontSize: 20,
        unselectedFontSize: 16,
        currentIndex: _selectedIndex,
        onTap: _onTappedItem,
      ),
      appBar: AppBar(
        title: const Text("Perfil"),
        
      ),
      );
  }
  void _onTappedItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
}