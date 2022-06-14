// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

void main() {
  runApp(const CepView());
}

class CepView extends StatefulWidget {
  const CepView({Key? key}) : super(key: key);

  @override
  State<CepView> createState() => _CepViewState();
}

class _CepViewState extends State<CepView> {
  int _selectedIndex = 2;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String endereco = "";
  final txtCepController = TextEditingController();
  final txtController = TextEditingController();
  final txtLogradouroController = TextEditingController();
  final txtBairroController = TextEditingController();
  final txtCidadeController = TextEditingController();
  final txtEstadoController = TextEditingController();
  final txtNumeroController = TextEditingController();
  final txtComplementoController = TextEditingController();
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  Future<void> consulta() async {
    var cep = txtController.text;
    String url = "https://viacep.com.br/ws/$cep/json/";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var dict = jsonDecode(response.body);

      if (!dict.containsKey('erro')) {
        txtLogradouroController.text = dict["logradouro"];
        txtBairroController.text = dict["bairro"];
        txtCidadeController.text = dict["localidade"];
        txtEstadoController.text = dict["uf"];
        txtComplementoController.text = dict["complemento"] ?? "";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
            controller: txtController,
          ),
          ElevatedButton(
            onPressed: consulta,
            child: Text("Consultar"),
          ),
        Form(
          key: formKey,
          child: Column(
            children: [
              TextField(
                controller: txtLogradouroController,
              ),
              TextField(
                controller: txtBairroController,
              ),
              TextField(
                controller: txtCidadeController,
              ),
              TextField(
                controller: txtEstadoController,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: txtNumeroController,
                decoration: InputDecoration(
                  labelText: 'Numero',
                  border: OutlineInputBorder(),
                ),
              ),
              TextField(
                keyboardType: TextInputType.text,
                controller: txtComplementoController,
                decoration: InputDecoration(
                  labelText: 'Complemento',
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    try {
                      firestore
                          .collection('usuarios')
                          .doc(auth.currentUser!.uid)
                          .collection('enderecos')
                          .doc(Uuid().v1())
                          .set({
                        "cep": txtController.text,
                        "bairro": txtBairroController.text,
                        "rua": txtLogradouroController.text,
                        "cidade": txtCidadeController.text,
                        "estado": txtEstadoController.text,
                        "numero": txtNumeroController.text,
                        "complemento": txtComplementoController.text,
                      });
                    } on FirebaseAuthException catch (e) {  
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Ocorreu um erro'),
                        ),
                      );
                    }
                  }
                },
                child: Text('Cadastrar endereço'),
              )
            ],
          ),
        ),
      ],
    );
  }
}
