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
  void carregausuario()async{
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;
    var user = auth.currentUser!;
    var usuario = await db.collection('usuarios').doc(user.uid).get();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('Hello'),
      ),
      
      
    );
  }
  void initState(){
    super.initState();
    carregausuario();
  }
  
}