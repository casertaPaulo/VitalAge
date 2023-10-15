// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vital_age/services/api_service.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => InfoPageState();
}

class InfoPageState extends State<InfoPage> {
  final TextEditingController _questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _questionController,
              decoration: const InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: 'Digite sua pergunta...',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Provider.of<IAService>(context, listen: false)
                    .completeChat(_questionController.text);
              },
              child: const Text('Perguntar ao GPT'),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Resposta do GPT:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8.0),
            Consumer<IAService>(
              builder: (BuildContext context, IAService value, Widget? child) {
                return Text(
                  value.resposta,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
