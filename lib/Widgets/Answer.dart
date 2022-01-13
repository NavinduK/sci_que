import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  const Answer({
    Key? key,
    required this.ans,
    required this.correct,
    required this.answerWasSelected,
    required this.answerColor,
    required this.answerTap,
  }) : super(key: key);

  final String ans;
  final bool correct;
  final bool answerWasSelected;
  final Color answerColor;
  final Function answerTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => answerTap(),
      child: Container(
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            // border: Border.all(color: answerColor, width: 3),
            borderRadius: defaultTargetPlatform == TargetPlatform.iOS
                ? BorderRadius.circular(30.0)
                : BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 25),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: ans,
                        style: TextStyle(color: answerColor, fontSize: 16)),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: answerWasSelected
                            ? Icon(
                                correct
                                    ? Icons.check_circle
                                    : Icons.cancel_sharp,
                                color: answerColor,
                              )
                            : Icon(
                                correct
                                    ? Icons.check_circle
                                    : Icons.cancel_sharp,
                                color: Colors.white,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
