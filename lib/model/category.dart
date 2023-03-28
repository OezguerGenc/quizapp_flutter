import 'dart:convert';
import 'package:flutterquizapp/model/question.dart';

class Category {
  final String categoryName;
  final List<Question> questions;

  Category(this.categoryName, this.questions);

  Map<String, dynamic> toMap() {
    return {
      'categoryName': categoryName,
      'questions': questions.map((question) => question.toMap()).toList(),
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      map['categoryName'],
      List<Question>.from(map['questions'].map((x) => Question.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));
}
