import 'package:flutter/material.dart';
import 'package:byteBank/models/transferencia.dart';
import 'package:byteBank/components/editor.dart';

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

    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);
      Navigator.pop(context, transferenciaCriada);
      debugPrint('$transferenciaCriada');
    }
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
              onPressed: () => widget._criaTransferencia(context),
              child: Text(_textoValorBotaoConfirmar),
            ),
          ],
        ),
      ),
    );
  }
}