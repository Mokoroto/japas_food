import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:japas_food/View/cadastro_cep.view.dart';
import 'package:japas_food/View/perfil.view.dart';
import 'dart:developer';

Future <void> addA(String nome,String descricao, int preco) async
{
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid;
  CollectionReference itens = FirebaseFirestore.instance.collection('usuarios/$uid/itens');
  

 bool test = false;

 await FirebaseFirestore.instance
        .collection('usuarios/$uid/itens')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['nome'].toString() == nome) 
        {
            int qt = int.parse(doc['quantidade'].toString());
           
            test = true;
            itens.doc(doc.id).update({
            'nome': nome,
            'descricao': descricao,
            'preco': preco,
            'quantidade':  qt + 1 ,
          })
          .then((value) => print("User Updated"))
          .catchError((error) => print("Failed to update user: $error"));

        }
      });
    });
 
  if(test == false){
   itens.add(
    { 
      'nome':nome,
      'descricao': descricao,
      'preco': preco,  
      'quantidade': 1 
    }).then((value) => print('foi'));
  }
}

Future <void> diminuir(String nome) async
{
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid;
  CollectionReference itens = FirebaseFirestore.instance.collection('usuarios/$uid/itens');
  

 await FirebaseFirestore.instance
        .collection('usuarios/$uid/itens')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['nome'].toString() == nome) 
        {
            int qt = int.parse(doc['quantidade'].toString());
           
            if(qt > 1){

            itens.doc(doc.id).update({
            'nome': nome,
            'descricao': doc['descricao'],
            'preco': doc['preco'],
            'quantidade':  qt - 1 ,
          })
          .then((value) => print("User Updated"))
          .catchError((error) => print("Failed to update user: $error"));
          
          }else{
             itens.doc(doc.id).delete().then((value) => print("User Deleted")).catchError((error) => print("Failed to delete user: $error"));
          }
            

        }
      });
    });
 
 
}




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
  static const List<Widget> _widgetOptions = <Widget>[];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {           
                  Navigator.of(context).pushNamed('/carrinho');
        }, child: Icon(Icons.shopping_cart),),

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

//♥
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: _selectedIndex == 0
              ? Text("Menu")
              : _selectedIndex == 1
                  ? Text("Perfil")
                  : _selectedIndex == 2
                  ? Text("Endereço")
                  : Text("Sair")
        ),


        body: _selectedIndex == 0
            ? StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: firestore.collection("Produto").snapshots(),
                builder: (_, snapshot) {
                  
                  if (!snapshot.hasData)
                    return const CircularProgressIndicator();
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (_, index) {
                      return Container(
                        child: ListTile(
                              title: Text(snapshot.data!.docs[index]["nome"]),
                              subtitle: Column(children: [
                                 Text( snapshot.data!.docs[index]["descricao"]),
                                 Text("Preço: " + snapshot.data!.docs[index]["preco"].toString())

                              ],),
                                 
                                  
                              trailing: Wrap(spacing: 12, children: <Widget>[
                                 IconButton(onPressed: (){
                                  diminuir(snapshot.data!.docs[index]["nome"],);
                                }, icon: Icon(Icons.horizontal_rule)),
                                
                                IconButton(onPressed: (){
                                  addA(
                                  snapshot.data!.docs[index]["nome"],
                                  snapshot.data!.docs[index]["descricao"],
                                  snapshot.data!.docs[index]["preco"]);
                                }, icon: Icon(Icons.add))
                    
                              ],),
                            ),

                            

                      );
                    },
                  );
                },
              )
            : _selectedIndex == 1
                ? PerfilView()
                : _selectedIndex == 2
                    ? CepView()
                    : ElevatedButton(
                        onPressed: () {
                          auth.signOut();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/', (Route<dynamic> route) => false);
                        },
                        child: Text("Sair")
        ),
      );
  }

  void _onTappedItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
