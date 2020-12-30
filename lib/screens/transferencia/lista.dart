import 'dart:convert';

import 'package:byteBank/components/progress.dart';
import 'package:flutter/material.dart';
import 'package:byteBank/models/transferencia.dart';
import 'package:byteBank/screens/transferencia/formulario.dart';
import 'package:http/http.dart';

const _tituloAppBar = 'Transferências';

class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> _transferencias = List();

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}

class ListaTransferenciasState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: FutureBuilder<List<Transferencia>>(
          future:
              Future.delayed(Duration(seconds: 1)).then((value) => findAll()),
          // future: findAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                Progress(
                  message: "Carregando Parceiros",
                );
                break;
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                if (snapshot.hasData) {
                  final List<Transferencia> TransferenciaList = snapshot.data;
                  debugPrint(TransferenciaList.toString());
                  if (TransferenciaList.isNotEmpty) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: TransferenciaList.length,
                      itemBuilder: (context, index) {
                        final Transferencia transf = TransferenciaList[index];
                        return ItemTransferencia(transf);
                      },
                    );
                  }
                }

                return CenteredMessage(
                  message: "Nenhum parceiro encontrado",
                  iconData: Icons.warning,
                );

                break;
            }
            return CenteredMessage(
              message: "Unknown error",
              iconData: Icons.error,
            );
          }),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future<Transferencia> future =
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          }));
          future.then((value) {
            findAll();
          });
        },
      ),
    );
  }

  // void atualizaLista(Transferencia transferenciaRecebida) {
  //   debugPrint('$transferenciaRecebida');
  //   Future.delayed(Duration(seconds: 1), () {
  //     if (transferenciaRecebida != null) {
  //       setState(() {
  //         widget._transferencias.add(transferenciaRecebida);
  //       });
  //     }
  //   });
  // }

  Future<List<Transferencia>> findAll() async {
    final Response response = await get('http://192.168.0.111:8000/transaction')
        .timeout(Duration(seconds: 15));

    final List<dynamic> decodedJson = jsonDecode(response.body);
    final List<Transferencia> list = new List();

    for (Map<String, dynamic> element in decodedJson) {
      Transferencia t = Transferencia(double.parse(element['valor']), int.parse(element['conta']));
      list.add(t);
    }
    debugPrint(list.toString());
    return list;
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
  }
}

class CenteredMessage extends StatelessWidget {
  final String message;
  final IconData iconData;

  CenteredMessage({this.message, this.iconData});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      child: Column(
        children: <Widget>[
          Icon(iconData),
          Text(
            message,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ],
      ),
      visible: iconData != null,
    );
  }
}
