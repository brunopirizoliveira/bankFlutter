import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:byteBank/screens/transferencia/lista.dart';

void main() => runApp(ByteBank());

class ByteBank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListaTransferencias(),
      theme: ThemeData(
        primaryColor: Colors.amber,
        accentColor: Colors.white54,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent,
          textTheme: ButtonTextTheme.primary
        )
      ),
    );
  }
}
