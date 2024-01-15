import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  //const MyWidget({super.key});
  final VoidCallback selectHandler;
  final String _answerText;
  final bool buttonColorbool;
  //VoidCallback bir şey döndermediğinde ve arguman almadığında kullanılır
  //Onun Dışında Function kullanılabilir
  Answer(this.selectHandler, this._answerText,this.buttonColorbool);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: Container(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: selectHandler,
          child: Text(
            _answerText,
            style: TextStyle(color: Colors.white),
          ),
          
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(buttonColorbool ? Color.fromARGB(255, 246, 90, 0):  Color.fromARGB(255, 44, 150, 237))),
        ),
      ),
    );
  }
}


