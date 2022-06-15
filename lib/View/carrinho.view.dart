import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CarrinhoView extends StatefulWidget {
  const CarrinhoView({Key? key}) : super(key: key);

  @override
  State<CarrinhoView> createState() => _CarrinhoViewState();
}


class _CarrinhoViewState extends State<CarrinhoView> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;


  void carregaitens() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;
    var user = auth.currentUser!;
    var usuario = await db.collection('usuarios/itens').doc(user.uid).get();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      children: [
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: firestore
                .collection("usuarios")
                .doc(auth.currentUser!.uid)
                .collection("itens")
                .snapshots(),
            builder: (_, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (_, index) {
                    return Container(
                        child: Column(
                      children: [
                        Text(
                          snapshot.data!.docs[index]["nome"],
                        ),
                        Text(
                          snapshot.data!.docs[index]["descricao"]
                        ),
                        Text("Preco: " +
                          snapshot.data!.docs[index]["preco"].toString()
                        ),
                         Text("Quantidade: " +
                           snapshot.data!.docs[index]["quantidade"].toString()
                         ),
                      ],
                    ));
                  },
                ),
              );
            },
          )
      ],
      ),
    );
  }
}