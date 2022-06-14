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
  int _selectedIndex = 0;
  final firestore = FirebaseFirestore.instance;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    
  ];


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

  void _onTappedItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
