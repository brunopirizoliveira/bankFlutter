import 'dart:convert';

import 'package:byteBank/components/transaction_auth_dialog.dart';
import 'package:byteBank/screens/transferencia/lista.dart';
import 'package:flutter/material.dart';
import 'package:byteBank/models/transferencia.dart';
import 'package:byteBank/components/editor.dart';
import 'package:http/http.dart';

const _tituloAppBar = 'Criando Transferência';
const _textoValorBotaoConfirmar = 'Confirmar';
const _rotuloCampoNumeroConta = 'Número da Conta';
const _hintCampoNumeroConta = '00000';
const _rotuloCampoValor = 'Valor';
const _hintCampoValor = '0.00';

class FormularioTransferencia extends StatefulWidget {
  final TextEditingController _controladorNumeroConta = TextEditingController();
  final TextEditingController _controladorValor = TextEditingController();

  void _criaTransferencia(BuildContext context) {
    final int numeroConta = int.tryParse(_controladorNumeroConta.text);
    final double valor = double.tryParse(_controladorValor.text);
    showDialog(
        context: context,
        builder: (context) {
          return TransactionAuthDialog(
            onConfirm: (String password) {
              if (password == '1111') {
                if (numeroConta != null && valor != null) {
                  final transferenciaCriada = Transferencia(valor, numeroConta);
                  this.saveTransaction(transferenciaCriada);
                }
              }
            },
          );
        }).then((value) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ListaTransferencias()));
    });
  }

  Future<Response> saveTransaction(Transferencia transferencia) async {
    final Response response = await post('http://192.168.0.111:8000/transaction',
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'conta': transferencia.numeroConta,
          'valor': transferencia.valor,
        }));
    debugPrint(response.body);
    return response;
  }

  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
              controller: widget._controladorNumeroConta,
              label: _rotuloCampoNumeroConta,
              hint: _hintCampoNumeroConta,
            ),
            Editor(
              controller: widget._controladorValor,
              label: _rotuloCampoValor,
              hint: _hintCampoValor,
              icon: Icons.monetization_on,
            ),
            RaisedButton(
              // onPressed: () => widget._approveTransaction(context),
              onPressed: () => widget._criaTransferencia(context),
              child: Text(_textoValorBotaoConfirmar),
            ),
          ],
        ),
      ),
    );
  }
}
