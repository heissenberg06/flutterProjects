import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  Result(this._score, this._resart);

  final VoidCallback _resart;
  //const MyWidget({super.key});
  final int _score;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        Text(
          'Skorunuz: $_score',
          style: TextStyle(fontSize: 36, fontStyle: FontStyle.italic),
        ),
        ElevatedButton(
          child: Text('Tekrar'),
          onPressed: _resart,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red)),
        ),
      ],
    ));
  }
}
