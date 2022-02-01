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
    setState(() {
      answerWasSelected = true;
      if (answerScore) {
        _totalScore++;
        correctAnswerSelected = true;
      }
      if (!endOfQuiz && !correctAnswerSelected) {
        Fluttertoast.showToast(
            msg: "Wrong answer",
            fontSize: 20,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            webPosition: "center");
      }
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
      if (_questionIndex + 1 == _questions.length) {
        endOfQuiz = true;
      }
    });
  }

  void _nextQuestion() {
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
                height: 30.0,
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
                height: 30.0,
              ),
              Container(
                width: double.infinity,
                height: 130.0,
                margin: EdgeInsets.only(left: 30.0, right: 30.0),
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
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
                  ans: answer['ans'].toString(),
                  correct: answer['score'] as bool,
                  answerWasSelected: answerWasSelected,
                  answerColor: answerWasSelected
                      ? answer['score'] as bool
                          ? Colors.green
                          : Colors.pinkAccent
                      : Color.fromRGBO(40, 37, 97, 1),
                  answerTap: () {
                    if (answerWasSelected) {
                      return;
                    }
                    _questionAnswered(answer['score'] as bool);
                  },
                ),
              ),
              SizedBox(height: 25.0),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0, left: 30.0, right: 30.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: defaultTargetPlatform == TargetPlatform.iOS
                        ? StadiumBorder()
                        : null,
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
                    endOfQuiz ? 'Finish' : 'Next Question',
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

final _questions = const [
  {
    'question': 'Which element is used to made the Electric bulb filament?',
    'answers': [
      {'ans': 'Copper', 'score': false},
      {'ans': 'Aluminum', 'score': false},
      {'ans': 'Lead', 'score': false},
      {'ans': 'Tungsten', 'score': true},
    ],
  },
  {
    'question':
        'Which of the following is a non metal liquid at room temperature?',
    'answers': [
      {'ans': 'Phosphorous', 'score': false},
      {'ans': 'Bromine', 'score': true},
      {'ans': 'Chlorine', 'score': false},
      {'ans': 'Helium', 'score': false},
    ],
  },
  {
    'question': 'Which of the following is used in pencils?',
    'answers': [
      {'ans': 'Graphite', 'score': true},
      {'ans': 'Silicon', 'score': false},
      {'ans': 'Charcoal', 'score': false},
      {'ans': 'Phosphorous', 'score': false},
    ],
  },
  {
    'question': 'Chemical formula for water is',
    'answers': [
      {'ans': 'NaAL02', 'score': false},
      {'ans': 'H20', 'score': true},
      {'ans': 'AL2O3', 'score': false},
      {'ans': 'CaSiO3', 'score': false},
    ],
  },
  {
    'question': 'The gas usually filled in the electric bulb is',
    'answers': [
      {'ans': 'Nitrogen', 'score': true},
      {'ans': 'Hydrogen', 'score': false},
      {'ans': 'Carbon dioxide', 'score': false},
      {'ans': 'Oxygen', 'score': false},
    ],
  },
  {
    'question': 'Which of the gas is not known as green house gas?',
    'answers': [
      {'ans': 'Methane', 'score': false},
      {'ans': 'Nitrous oxide', 'score': false},
      {'ans': 'Carbon dioxide', 'score': false},
      {'ans': 'Hydrogen', 'score': true},
    ],
  },
  {
    'question': 'In which of the following activities silicon carbide is used?',
    'answers': [
      {'ans': 'Making cement and glass', 'score': false},
      {'ans': 'Disinfecting water of ponds', 'score': false},
      {'ans': 'Cutting very hard substances', 'score': true},
      {'ans': 'Making casts for statues', 'score': false},
    ],
  },
  {
    'question': 'Carbon, diamond and graphite are together called',
    'answers': [
      {'ans': 'Allotrope', 'score': true},
      {'ans': 'Isomers', 'score': false},
      {'ans': 'Isomorphs', 'score': false},
      {'ans': 'Isotopes', 'score': false},
    ],
  },
  {
    'question': 'Potassium nitrate is used in',
    'answers': [
      {'ans': 'Medicine', 'score': false},
      {'ans': 'Fertilizer', 'score': true},
      {'ans': 'Salt', 'score': false},
      {'ans': 'Glass', 'score': false},
    ],
  },
  {
    'question':
        'Permanent hardness of water may be removed by the addition of:',
    'answers': [
      {'ans': 'Sodium Carbonate', 'score': true},
      {'ans': 'Aluminum', 'score': false},
      {'ans': 'Potassium Permanganate', 'score': false},
      {'ans': 'Lime', 'score': false},
    ],
  },
  // {
  //   'question': 'Which of the following is in liquid form at room temperature?',
  //   'answers': [
  //     {'ans': 'Lithium', 'score': false},
  //     {'ans': 'Aluminum', 'score': false},
  //     {'ans': 'Francium', 'score': true},
  //     {'ans': 'Cerium', 'score': false},
  //   ],
  // },
];

// final _questions = const [
//   {
//     'question': 'question',
//     'answers': [
//       {'ans': 'ans', 'score': true},
//       {'ans': 'ans', 'score': false},
//       {'ans': 'ans', 'score': false},
//       {'ans': 'ans', 'score': false},
//     ],
//   },

// ];