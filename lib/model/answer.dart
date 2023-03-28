import 'dart:ffi';

class Answer {
  final bool correct;
  final String text;

  Answer(this.correct, this.text);

  Map<String, dynamic> toMap() {
    return {
      'correct': correct,
      'text': text,
    };
  }

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      map['correct'],
      map['text'],
    );
  }
}
