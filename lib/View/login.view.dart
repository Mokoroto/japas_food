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
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 245, 233, 66),
              Color.fromARGB(122, 63, 226, 255),
            ],
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/LOGO.png'),
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
                      const Text('N??o possui cadastro?'),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/cadastro');
                        },
                        child: const Text('Cadastre-se'),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    child: Text('Entrar'),
                    onPressed: () async {
                      // login(String email, String senha) async {
                      try {
                        print(email);
                        print(senha);
                        await auth.signInWithEmailAndPassword(
                            email: email, password: senha);

                        Navigator.of(context).pushNamed('/menu');
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Usu??rio n??o foi encontrado. Por favor realize o cadastro'),
                            ),
                          );
                        } else if (e.code == 'wrong-password') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Email ou senha incorretos! Tente novamente.'),
                            ),
                          );
                        }
                      }
                      // }
                    },
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
