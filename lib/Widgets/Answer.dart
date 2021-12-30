import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  const Answer({
    Key? key,
    required this.answerText,
    required this.answerColor,
    required this.answerTap,
  }) : super(key: key);

  final String answerText;
  final Color answerColor;
  final Function answerTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => answerTap(),
      child: Container(
          padding: EdgeInsets.all(15.0),
          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: answerColor, width: 3),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: RichText(
            text: TextSpan(
              // style: Theme.of(context).textTheme.body1,
              children: [
                TextSpan(
                    text: answerText, style: TextStyle(color: answerColor)),
                WidgetSpan(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Icon(
                      Icons.check_circle,
                      color: answerColor,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
