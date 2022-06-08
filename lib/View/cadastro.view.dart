import 'package:flutter/material.dart';

class CadastroView extends StatefulWidget {
  CadastroView({Key? key}) : super(key: key);

  @override
  State<CadastroView> createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> {
  double displayHeight() => MediaQuery.of(context).size.height;
  double displayWidth() => MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      child: Container(
        color: const Color.fromARGB(255, 4, 0, 255),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 500,
                width: 450,
                child: Image.asset('images/logo_japas_food.jpeg'),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 4,
                  right: displayWidth() / 20,
                  left: displayWidth() / 20,
                ),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: const TextField(
                  keyboardType: TextInputType.name,
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    hintText: 'Nome Completo',
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                  right: displayWidth() / 20,
                  left: displayWidth() / 20,
                ),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: const TextField(
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    hintText: 'E-mail',
                    prefixIcon: Icon(
                      Icons.alternate_email,
                      color: Colors.blue,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                  right: displayWidth() / 20,
                  left: displayWidth() / 20,
                ),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: const TextField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    hintText: 'Senha',
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: Colors.blue,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                  right: displayWidth() / 20,
                  left: displayWidth() / 20,
                ),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: const TextField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    hintText: 'Confirmar Senha',
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: Colors.blue,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                  right: displayWidth() / 20,
                  left: displayWidth() / 20,
                ),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: const TextField(
                  keyboardType: TextInputType.phone,
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    hintText: 'Telefone Ex: (17) 98888-8888',
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.blue,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                margin: EdgeInsets.symmetric(
                  horizontal: displayWidth() / 20,
                  vertical: 25,
                ),
                color: Colors.blue,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Cadastrar-se',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
