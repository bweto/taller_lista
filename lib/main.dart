import 'package:flutter/material.dart';
import 'src/randomWords.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
 Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Lista de palabras',
      theme: ThemeData(fontFamily: 'Laila'),
      home: new Scaffold(
      body: new Center(
          child: new RandomWords(),
        ),
      ),
    );
  }

}

 
 
 