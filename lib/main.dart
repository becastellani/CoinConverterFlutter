import 'dart:math';
import 'package:flutter/material.dart';
import './coins.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Dashboard'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            ListTile(
              title: Text('Gerador de Senha'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GeradorDeSenhaApp()),
                );
              },
            ),
            ListTile(
              title: Text('Conversor de Moedas'),
              onTap: () {
               Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConversorDeMoedasApp()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Bem-vindo! Selecione uma opção no menu.'),
      ),
    );
  }
}

class GeradorDeSenhaApp extends StatefulWidget {
  @override
  GeradorDeSenhaAppState createState() {
    return GeradorDeSenhaAppState();
  }
}

class GeradorDeSenhaAppState extends State<GeradorDeSenhaApp> {
  bool maiuscula = true;
  bool minuscula = true;
  bool caracterespecial = true;
  bool numeros = true;
  double range = 6;
  String pass = '';
  String mensagemAlerta = "";
  Color corAlerta = Colors.red;

  void geradorDeSenhaState() {
    setState(() {
      pass = geradorSenha();
      verificarForcaSenha(pass);
    });
  }

  String geradorSenha() {
    List<String> charList = <String>[
      maiuscula ? 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' : '',
      minuscula ? 'abcdefghijklmnopqrstuvwxyz' : '',
      numeros ? '0123456789' : '',
      caracterespecial ? '!@#\$%&*-=+,.<>;:/?' : ''
    ];

    final String chars = charList.join('');
    Random rnd = Random();

    return String.fromCharCodes(Iterable.generate(
        range.round(), (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  void verificarForcaSenha(String senha) {
    bool temMaiuscula = senha.contains(RegExp(r'[A-Z]'));
    bool temMinuscula = senha.contains(RegExp(r'[a-z]'));
    bool temNumero = senha.contains(RegExp(r'[0-9]'));
    bool temCaractereEspecial = senha.contains(RegExp(r'[!@#\$%&*-=+,.<>;:/?]'));
    bool comprimentoSuficiente = senha.length >= 5;

    if (temMaiuscula && temMinuscula && temNumero && temCaractereEspecial && comprimentoSuficiente) {
      mensagemAlerta = "Senha forte";
      corAlerta = Colors.green;
    } else {
      mensagemAlerta = "Senha fraca";
      corAlerta = Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerador de Senhas'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Home Page'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            ListTile(
              title: Text('Gerador de Senha'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GeradorDeSenhaApp()),
                );
              },
            ),
            ListTile(
              title: Text('Próximo Gerador'),
onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConversorDeMoedasApp()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          sizedBoxImg(),
          textoMaior(),
          textoMenor(),
          sizedBox(),
          opcoes(),
          sizedBox(),
          slider(),
          alerta(mensagemAlerta),
          botao(),
          sizedBox(),
          resultado(),
        ],
      ),
    );
  }

  Widget sizedBoxImg() {
    return SizedBox(
      width: 200,
      height: 200,
      child: Image.network(
          'https://cdn.pixabay.com/photo/2013/04/01/09/02/read-only-98443_1280.png'),
    );
  }

  Widget textoMenor() {
    return const Text(
      'Aqui você escolhe como desejar gerar sua senha',
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
      textAlign: TextAlign.center,
    );
  }

  Widget textoMaior() {
    return const Text(
      'Gerador automático de senha',
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
      textAlign: TextAlign.center,
    );
  }

  Widget alerta(String mensagemAlerta) {
    return Center(
      child: Text(
        mensagemAlerta,
        style: TextStyle(fontSize: 20, color: corAlerta),
      ),
    );
  }

  Widget sizedBox() {
    return const SizedBox(
      height: 30,
    );
  }

  Widget opcoes() {
    return Row(children: [
      Checkbox(
          value: maiuscula,
          onChanged: (bool? value) {
            setState(() {
              maiuscula = value!;
            });
          }),
      Text('[A-Z]'),
      Checkbox(
          value: minuscula,
          onChanged: (bool? value) {
            setState(() {
              minuscula = value!;
            });
          }),
      Text('[a-z]'),
      Checkbox(
          value: numeros,
          onChanged: (bool? value) {
            setState(() {
              numeros = value!;
            });
          }),
      Text('[0-9]'),
      Checkbox(
          value: caracterespecial,
          onChanged: (bool? value) {
            setState(() {
              caracterespecial = value!;
            });
          }),
      Text('[@#!]'),
    ]);
  }

  Widget botao() {
    return Container(
      height: 50,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: ElevatedButton(
        onPressed: geradorDeSenhaState,
        child: const Text('Gerar senha'),
      ),
    );
  }

  Widget slider() {
    return Slider(
      value: range,
      max: 50,
      divisions: 50,
      label: range.round().toString(),
      onChanged: (double newRange) {
        setState(() {
          range = newRange;
        });
      },
    );
  }

  Widget resultado() {
    return Container(
        height: 50,
        width: MediaQuery.of(context).size.width * .70,
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: Text(
            pass,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
          ),
        ));
  }
}