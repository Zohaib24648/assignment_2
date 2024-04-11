import 'package:flutter/material.dart';
import 'package:assignment_2/Screens/MyHomePage.dart';
import 'package:provider/provider.dart';

import 'Providers/dataprovider.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => dataProvider(),
      child: MaterialApp(
        title: 'Pokedex',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}