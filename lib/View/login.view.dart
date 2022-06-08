import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LogarState();
}

class _LogarState extends State<LoginView> {
  FirebaseAuth auth = FirebaseAuth.instance;
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
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/logo_japas_food.jpeg'),
              TextField(
                onChanged: (text) {
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
                onChanged: (text) {
                  senha = text;
                },
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Text('Não possui cadastro?'),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/cadastro');
                        },
                        child: const Text('Cadastre-se'),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      auth.signInWithEmailAndPassword(
                          email: email, password: senha);
                      Navigator.of(context).pushNamed('/perfil');
                    },
                    child: Text('Entrar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
