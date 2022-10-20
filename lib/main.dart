import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'get_prediction.dart';

Future<GetPrediction> askPrediction() async {
  final response = await http.post(
    Uri.parse('https://water-quality-fast-api.herokuapp.com/predict'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, double>{
      "ph": 1000,
      "Hardness": 1000,
      "Solids": 10000,
      "Chloramines": 1000,
      "Sulfate": 1000,
      "Conductivity": 10000,
      "Organic_carbon": 0,
      "Trihalomethanes": 0,
      "Turbidity": 0
    }),
  );

  if (response.statusCode == 200) {
    return GetPrediction.fromJson(jsonDecode(response.body));
  } else {
    log('Request failed with status: ${response.statusCode}.');
    throw Exception('Failed to fetch');
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String predicted = "no_call";
  Future<void> _incrementCounter() async {
    final GetPrediction pred = await askPrediction();
    setState(() {
      predicted = pred.result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              predicted,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
