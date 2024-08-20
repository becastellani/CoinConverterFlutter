import 'package:flutter/material.dart';
import './main.dart';

void main() {
  runApp(ConversorDeMoedasApp());
}

class ConversorDeMoedasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ConversorDeMoedasPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ConversorDeMoedasPage extends StatefulWidget {
  @override
  _ConversorDeMoedasPageState createState() => _ConversorDeMoedasPageState();
}

class _ConversorDeMoedasPageState extends State<ConversorDeMoedasPage> {
  final TextEditingController _amountController = TextEditingController();
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  String _convertedAmount = '';

  final List<String> _currencies = ['USD', 'EUR', 'JPY', 'BRL'];

  final Map<String, Map<String, double>> _conversionRates = {
    'USD': {'EUR': 0.92, 'JPY': 110.0, 'BRL': 5.2},
    'EUR': {'USD': 1.09, 'JPY': 120.0, 'BRL': 5.6},
    'JPY': {'USD': 0.0091, 'EUR': 0.0083, 'BRL': 0.046},
    'BRL': {'USD': 0.19, 'EUR': 0.18, 'JPY': 21.7},
  };

  void _convert() {
    double amount = double.tryParse(_amountController.text) ?? 0;
    double rate = _conversionRates[_fromCurrency]?[_toCurrency] ?? 1.0;
    double converted = amount * rate;
    setState(() {
      _convertedAmount = converted.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor de Moedas'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                height: 100,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Digite o valor',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _fromCurrency,
                    decoration: InputDecoration(
                      labelText: 'Moeda de Origem',
                      border: OutlineInputBorder(),
                    ),
                    items: _currencies.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _fromCurrency = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _toCurrency,
                    decoration: InputDecoration(
                      labelText: 'Moeda de Destino',
                      border: OutlineInputBorder(),
                    ),
                    items: _currencies.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _toCurrency = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convert,
              child: const Text('Converter'),
            ),
            const SizedBox(height: 20),
            if (_convertedAmount.isNotEmpty)
              Text(
                'Valor Convertido: $_convertedAmount $_toCurrency',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}