// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String endereco = "";
  final txtController = TextEditingController();
  final txtLogradouroController = TextEditingController();
  final txtBairroController = TextEditingController();
  final txtCidadeController = TextEditingController();
  final txtEstadoController = TextEditingController();

  Future<void> consulta() async {
    var CEP = txtController.text;
    int numero = 0;
    String url = "https://viacep.com.br/ws/$CEP/json/";
    
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200)
    {
      // endereco = response.body;
      var dict = jsonDecode(response.body) as Map;

      if(!dict.containsKey('erro')) {
        txtLogradouroController.text = dict["logradouro"];
        txtBairroController.text = dict["bairro"];
        txtCidadeController.text = dict["localidade"];
        txtEstadoController.text = dict["uf"];
        TextField(
                onChanged: (text) {
                  numero = numero;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'numero',
                  border: OutlineInputBorder(),
                ),
              );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text("API Demo"),
        ),
        body: Column(
          children: [
            TextField(
              controller: txtController,
            ),
            ElevatedButton(
              onPressed: consulta,
              child: Text("Consultar"),
            ),
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
          ],
        ),
      ),
    );
  }
}
