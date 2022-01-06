import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sci_que/Util/Util.dart';
import 'package:sci_que/Views/Home.dart';
import 'package:sci_que/Widgets/Answer.dart';
import 'package:sci_que/Widgets/ScaffoldWidget.dart';

class Question extends StatefulWidget {
  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  List<Icon> _scoreTracker = [];
  int _questionIndex = 0;
  int _totalScore = 0;
  bool answerWasSelected = false;
  bool endOfQuiz = false;
  bool correctAnswerSelected = false;

  void _questionAnswered(bool answerScore) {
    print("answered");
    setState(() {
      // answer was selected
      answerWasSelected = true;
      // check if answer was correct
      if (answerScore) {
        _totalScore++;
        correctAnswerSelected = true;
      }
      print(answerWasSelected);
      print(endOfQuiz);
      print(correctAnswerSelected);
      if (!endOfQuiz && !correctAnswerSelected) {
        print('correct toast');
        Fluttertoast.showToast(
            msg: "Wrong answer",
            fontSize: 20,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            webPosition: "center");
      }
      // adding to the score tracker on top
      _scoreTracker.add(
        answerScore
            ? Icon(
                Icons.check_circle,
                color: Colors.green,
              )
            : Icon(
                Icons.cancel_sharp,
                color: Colors.pinkAccent,
              ),
      );
      //when the quiz ends
      if (_questionIndex + 1 == _questions.length) {
        endOfQuiz = true;
      }
    });
  }

  void _nextQuestion() {
    print('next');
    setState(() {
      _questionIndex++;
      answerWasSelected = false;
      correctAnswerSelected = false;
    });
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      _scoreTracker = [];
      correctAnswerSelected = false;
      answerWasSelected = false;
      endOfQuiz = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      app: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text(
          'QUESTION ${(_questionIndex + 1).toString()}',
          style: TextStyle(
              color: Colors.white, fontSize: 21, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_scoreTracker.length == 0)
                    SizedBox(
                      height: 24.0,
                    ),
                  if (_scoreTracker.length > 0) ..._scoreTracker
                ],
              ),
              SizedBox(
                height: 40.0,
              ),
              Container(
                width: double.infinity,
                height: 130.0,
                margin: EdgeInsets.only(left: 30.0, right: 30.0),
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: Colors.pinkAccent,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    _questions[_questionIndex]['question'] as String,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              ...(_questions[_questionIndex]['answers']
                      as List<Map<String, Object>>)
                  .map(
                (answer) => Answer(
                  answerText: answer['answerText'].toString(),
                  correct: answer['score'] as bool,
                  answerWasSelected: answerWasSelected,
                  answerColor: answerWasSelected
                      ? answer['score'] as bool
                          ? Colors.green
                          : Colors.pinkAccent
                      : Color.fromRGBO(40, 37, 97, 1),
                  answerTap: () {
                    // if answer was already selected then nothing happens onTap
                    if (answerWasSelected) {
                      print('already selected');
                      return;
                    }
                    //answer is being selected
                    _questionAnswered(answer['score'] as bool);
                  },
                ),
              ),
              SizedBox(height: 25.0),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0, left: 30.0, right: 30.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pinkAccent,
                    minimumSize: Size(double.infinity, 70.0),
                  ),
                  onPressed: () {
                    if (!answerWasSelected) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.pinkAccent,
                        content: Text(
                          'Select an answer before going to the next question',
                          textAlign: TextAlign.center,
                        ),
                      ));
                      return;
                    }
                    if (endOfQuiz) {
                      AwesomeDialog(
                        width: kIsWeb ? 450 : null,
                        context: context,
                        dialogType: _totalScore > 4
                            ? DialogType.SUCCES
                            : DialogType.ERROR,
                        headerAnimationLoop: true,
                        animType: AnimType.BOTTOMSLIDE,
                        title: _totalScore > 4
                            ? 'Congratulations!'
                            : 'Better luck next time!',
                        desc: 'Score: $_totalScore',
                        buttonsTextStyle: TextStyle(color: Colors.black),
                        showCloseIcon: false,
                        btnCancelText: 'Home',
                        btnCancelOnPress: () =>
                            UtilFunctions.navigateTo(context, HOME()),
                        btnOkText: 'Retry',
                        btnOkOnPress: () {
                          _resetQuiz();
                        },
                      )..show();
                    } else
                      _nextQuestion();
                  },
                  child: Text(
                    endOfQuiz ? 'Restart Quiz' : 'Next Question',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// final _questions = const [
//   {
//     'question': 'question',
//     'answers': [
//       {'answerText': 'answerText', 'score': true},
//       {'answerText': 'answerText', 'score': false},
//       {'answerText': 'answerText', 'score': false},
//     ],
//   },

// ];

final _questions = const [
  {
    'question': 'How long is New Zealand’s Ninety Mile Beach?',
    'answers': [
      {'answerText': '88km, so 55 miles long.', 'score': true},
      {'answerText': '55km, so 34 miles long.', 'score': false},
      {'answerText': '90km, so 56 miles long.', 'score': false},
    ],
  },
  {
    'question':
        'In which month does the German festival of Oktoberfest mostly take place?',
    'answers': [
      {'answerText': 'January', 'score': false},
      {'answerText': 'October', 'score': false},
      {'answerText': 'September', 'score': true},
    ],
  },
  {
    'question': 'Who composed the music for Sonic the Hedgehog 3?',
    'answers': [
      {'answerText': 'Britney Spears', 'score': false},
      {'answerText': 'Timbaland', 'score': false},
      {'answerText': 'Michael Jackson', 'score': true},
    ],
  },
  {
    'question': 'In Georgia (the state), it’s illegal to eat what with a fork?',
    'answers': [
      {'answerText': 'Hamburgers', 'score': false},
      {'answerText': 'Fried chicken', 'score': true},
      {'answerText': 'Pizza', 'score': false},
    ],
  },
  {
    'question':
        'Which part of his body did musician Gene Simmons from Kiss insure for one million dollars?',
    'answers': [
      {'answerText': 'His tongue', 'score': true},
      {'answerText': 'His leg', 'score': false},
      {'answerText': 'His butt', 'score': false},
    ],
  },
  {
    'question': 'In which country are Panama hats made?',
    'answers': [
      {'answerText': 'Ecuador', 'score': true},
      {'answerText': 'Panama (duh)', 'score': false},
      {'answerText': 'Portugal', 'score': false},
    ],
  },
  {
    'question': 'From which country do French fries originate?',
    'answers': [
      {'answerText': 'Belgium', 'score': true},
      {'answerText': 'France (duh)', 'score': false},
      {'answerText': 'Switzerland', 'score': false},
    ],
  },
  {
    'question': 'Which sea creature has three hearts?',
    'answers': [
      {'answerText': 'Great White Sharks', 'score': false},
      {'answerText': 'Killer Whales', 'score': false},
      {'answerText': 'The Octopus', 'score': true},
    ],
  },
  {
    'question': 'Which European country eats the most chocolate per capita?',
    'answers': [
      {'answerText': 'Belgium', 'score': false},
      {'answerText': 'The Netherlands', 'score': false},
      {'answerText': 'Switzerland', 'score': true},
    ],
  },
];
