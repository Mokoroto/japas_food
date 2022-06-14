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
  String? nome = '';
  String? email = '';
  String? telefone = '';
  FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  int _selectedIndex = 1;
  void carregausuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;
    var user = auth.currentUser!;
    var usuario = await db.collection('usuarios').doc(user.uid).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.menu),
      //        label: 'Cardápio',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.account_circle_sharp),
      //        label: 'Perfil',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.add_home_sharp),
      //        label: 'Endereco',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.logout),
      //        label: 'Sair',
      //     ),
      //   ],
      //   unselectedItemColor: Colors.black,
      //   selectedItemColor: Colors.amber[900],
      //   selectedFontSize: 20,
      //   unselectedFontSize: 16,
      //   currentIndex: _selectedIndex,
      //   onTap: _onTappedItem,
      // ),
      // appBar: AppBar(
      //   title: const Text("Perfil"),

      // ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: firestore
                .collection("usuarios")
                .where("uid", isEqualTo: auth.currentUser!.uid)
                .snapshots(),
            builder: (_, snapshot) {
              if (!snapshot.hasData) return const CircularProgressIndicator();
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text(snapshot.data!.docs[index]["nome"]),
                    subtitle: Text(snapshot.data!.docs[index]["telefone"]),
                    //subtitle: Text(snapshot.data!.docs[index]["email"]),
                  );
                },
              );
            },
          ),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: firestore
                .collection("usuarios")
                .doc(auth.currentUser!.uid)
                .collection("enderecos")
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
                          snapshot.data!.docs[index]["cep"],
                        ),
                        Text(
                          snapshot.data!.docs[index]["rua"] +
                              ", " +
                              snapshot.data!.docs[index]["numero"],
                        ),
                        Text(
                          snapshot.data!.docs[index]["bairro"],
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

  void _onTappedItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
