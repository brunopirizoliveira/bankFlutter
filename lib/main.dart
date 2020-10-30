import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Trasnferências'),
          ),
          body: Column(
            children: <Widget>[
              Card(
                  child: ListTile(
                leading: Icon(Icons.monetization_on),
                title: Text('100,00'),
                subtitle: Text('24572-5'),
              )),
              Card(
                  child: ListTile(
                leading: Icon(Icons.monetization_on),
                title: Text('100,00'),
                subtitle: Text('24572-5'),
              )),
              Card(
                  child: ListTile(
                leading: Icon(Icons.monetization_on),
                title: Text('100,00'),
                subtitle: Text('24572-5'),
              )),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
