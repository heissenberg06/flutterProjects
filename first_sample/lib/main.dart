import 'package:flutter/material.dart';
import 'quiz.dart';
import 'result.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  var _questionI = 0;
  var score = 0;

  final questions = const [
    {
      'QuestionText': '15+30?',
      'Answers': [
        {'Text': '25', "isCorrect": 0},
        {'Text': '45', "isCorrect": 1},
        {'Text': '65', 'isCorrect': 0},
        {'Text': '43', 'isCorrect': 0}
      ],
    }, //map()

    {
      'QuestionText': 'Hangisi MMORPG\'dir?',
      'Answers': [
        {'Text': 'Valorant', 'isCorrect': 0},
        {'Text': 'Lol', 'isCorrect': 0},
        {'Text': 'Metin 2', 'isCorrect': 1}
      ],
    }, //map()

    {
      'QuestionText': 'Hangisi High Level dildir?',
      'Answers': [
        {'Text': 'c', 'isCorrect': 0},
        {'Text': '.py', 'isCorrect': 1},
        {'Text': '.Asm', 'isCorrect': 0}
      ],
    },
    {
      'QuestionText': 'Hangisi High Level dildir?',
      'Answers': [
        {'Text': 'c', 'isCorrect': 0},
        {'Text': '.py', 'isCorrect': 1},
        {'Text': '.Asm', 'isCorrect': 0},
        {'Text': 'Yüz felci', 'isCorrect': 0}
      ],
    },
    {
      'QuestionText': 'Hangisi High Level dildir?',
      'Answers': [
        {'Text': 'c', 'isCorrect': 0},
        {'Text': '.py', 'isCorrect': 1},
        {'Text': '.Asm', 'isCorrect': 0}
      ],
    },
    {
      'QuestionText': 'Hangisi High Level dildir?',
      'Answers': [
        {'Text': 'c', 'isCorrect': 0},
        {'Text': '.py', 'isCorrect': 1},
        {'Text': '.Asm', 'isCorrect': 0}
      ],
    }, //map()
  ];

  void answerQuestion(int isCorrect) {
    if (isCorrect == 1) {
      score++;
    }
    setState(() {
      _questionI++;
    });
  }

  void restartGame() {
    setState(() {
      _questionI = 0;
      score = 0;
    });
  }

  bool isDark = false;
  void dark(bool value) {
    if (isDark == false) {
      setState(() {
        isDark = true;
      });
    } else {
      setState(() {
        isDark = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(title: const Text('First App')),
          body: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(300, 0, 0, 0),
                child: Switch(
                  value: isDark,
                  onChanged: dark,
                  activeColor:  Color.fromARGB(255, 246, 90, 0),
                  inactiveThumbColor: Colors.black,
                ),
              ),
              Container(
                child: _questionI < questions.length
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(0, 180, 0, 0),
                        child: Quiz(answerQuestion, questions, _questionI, isDark),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [Result(score,restartGame)],
                      ),
              ),
            ],
          )),
      theme: isDark ? ThemeData.dark() : ThemeData.light(),
    );
  }
}
