import 'package:flutter/material.dart';
import 'questions.dart';
import 'answer.dart';

class Quiz extends StatelessWidget {
  //const MyWidget({super.key});
  final List<Map<String, Object>> questions;
  final int ourquestion;
  final Function answerQuestion;
  final bool isDark;
  Quiz(@required this.answerQuestion,
       @required this.questions,
       @required this.ourquestion,
       @required this.isDark);

  @override
  Widget build(BuildContext context) {
    return Column(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Questions(questions[ourquestion]['QuestionText'] as String),

        ...(questions[ourquestion]['Answers'] as List<Map<String,Object>>).map((answer) {
          return Answer((() => answerQuestion(answer['isCorrect'])), answer['Text'] as String,isDark);
        }).toList() //map orjinal listi değiştirmez list oluşturur
      ],
    );
  }
}
