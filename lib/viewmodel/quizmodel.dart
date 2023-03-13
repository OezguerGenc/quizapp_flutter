import 'package:firebase_database/firebase_database.dart';
import 'package:flutterquizapp/model/answer.dart';
import 'package:flutterquizapp/model/question.dart';

class QuizModel {
  final databaseRef = FirebaseDatabase.instance.ref().child("questions");

  Future<List<Question>> loadQuestions() async {
    List<Question> questionlist = [];
    await databaseRef.onValue.listen((event) {
      for (var i = 0; i < 100; i++) {
        if (event.snapshot.child("$i/text").value != null) {
          List<Answer> answers = [];
          for (var j = 0; j < 4; j++) {
            if (event.snapshot.child("$i/answer/$j/text").value != null) {
              print(event.snapshot.child("$i/answer/$j/text").value.toString());
              answers.add(Answer(
                  event.snapshot.child("$i/answer/$j/correct").value as bool,
                  event.snapshot.child("$i/answer/$j/text").value.toString()));
            } else {
              break;
            }
          }
          questionlist.add(Question(
              event.snapshot.child("$i/text").value.toString(), answers));
          answers.clear();
        } else {
          break;
        }
      }
    });
    return questionlist;
  }
}