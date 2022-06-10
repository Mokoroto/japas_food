import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MenuView extends StatefulWidget {
  const MenuView({Key? key}) : super(key: key);

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("menu"),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firestore.collection("Produto").snapshots(),
        builder: (_, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (_, index) {
              return Container(
                child: ListTile(
                  title: Text(snapshot.data!.docs[index]["nome"]),
                  subtitle: Text(snapshot.data!.docs[index]["descricao"]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
