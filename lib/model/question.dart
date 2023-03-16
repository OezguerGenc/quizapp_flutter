import 'dart:convert';

import 'package:flutterquizapp/model/answer.dart';

class Question {
  final String text;
  final List<Answer> answers;

  Question(this.text, this.answers);

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'answers': answers.map((answer) => answer.toMap()).toList(),
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      map['text'],
      List<Answer>.from(map['answers'].map((x) => Answer.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));
}
