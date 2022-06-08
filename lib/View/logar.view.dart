import 'package:flutter/material.dart';

class LogarView extends StatefulWidget {
  const LogarView({Key? key}) : super(key: key);

  @override
  State<LogarView> createState() => _LogarState();
}

class _LogarState extends State<LogarView> {
  String email = '';
  String senha = '';
  
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/logo_japas_food.jpeg'),
              TextField(
                onChanged: (text){
                  email = text;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                onChanged: (text){
                  senha = text;
                },
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  RaisedButton(onPressed: () {},
                    child: Text('Entrar'),
                  
                )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}