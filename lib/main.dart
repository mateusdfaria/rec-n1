import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ranson Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RansonCalculator(),
    );
  }
}

class RansonCalculator extends StatefulWidget {
  @override
  _RansonCalculatorState createState() => _RansonCalculatorState();
}

class _RansonCalculatorState extends State<RansonCalculator> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController wbcController = TextEditingController();
  TextEditingController glucoseController = TextEditingController();
  TextEditingController astController = TextEditingController();
  TextEditingController ldhController = TextEditingController();
  bool gallstonePancreatitis = false;

  int score = 0;
  double mortality = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Novo Paciente',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextFormField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Idade'),
            ),
            Row(
              children: [
                Text('Litíase Biliar:'),
                Checkbox(
                  value: gallstonePancreatitis,
                  onChanged: (value) {
                    setState(() {
                      gallstonePancreatitis = value!;
                    });
                  },
                ),
              ],
            ),
            TextFormField(
              controller: wbcController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Leucócitos'),
            ),
            TextFormField(
              controller: glucoseController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Glicemia'),
            ),
            TextFormField(
              controller: astController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'AST/TGO'),
            ),
            TextFormField(
              controller: ldhController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'LDH'),
            ),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  // Alterando a função de cálculo e adicionando paciente
                  addPatient();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // Cor do botão
                  onPrimary: Colors.white, // Cor do texto do botão
                  padding: EdgeInsets.all(16.0), // Preenchimento do botão
                  textStyle: TextStyle(fontSize: 20), // Tamanho do texto do botão
                ),
                child: Text('Adicionar Paciente'),
              ),
            ),
            if (score > 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text('Pontuação: $score'),
                  Text('Mortalidade: ${mortality.toStringAsFixed(2)}%'),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void addPatient() {
    int age = int.tryParse(ageController.text) ?? 0;
    int wbc = int.tryParse(wbcController.text) ?? 0;
    int glucose = int.tryParse(glucoseController.text) ?? 0;
    int ast = int.tryParse(astController.text) ?? 0;
    int ldh = int.tryParse(ldhController.text) ?? 0;

    score = 0;

    if (!gallstonePancreatitis) {
      if (age > 55) score++;
      if (wbc > 16000) score++;
      if (glucose > 11) score++;
      if (ast > 250) score++;
      if (ldh > 350) score++;
    } else {
      if (age > 70) score++;
      if (wbc > 18000) score++;
      if (glucose > 12.2) score++;
      if (ast > 250) score++;
      if (ldh > 400) score++;
    }

    // Cálculo da mortalidade
    if (score >= 7) {
      mortality = 100.0;
    } else if (score >= 5) {
      mortality = 40.0;
    } else if (score >= 3) {
      mortality = 15.0;
    } else {
      mortality = 2.0;
    }

    // Exemplo de exibição de um diálogo com os resultados:
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Resultados dos Critérios de Ranson'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Idade: $age'),
              Text('Contagem de Leucócitos: $wbc'),
              // Adicione mais resultados conforme necessário
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
    setState(() {});
  }
}
