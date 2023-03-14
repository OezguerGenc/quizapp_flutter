import 'package:firebase_database/firebase_database.dart';
import 'package:flutterquizapp/model/answer.dart';
import 'package:flutterquizapp/model/question.dart';

class QuizModel {
  final databaseRef = FirebaseDatabase.instance.ref().child("questions");
  List<bool> isSelectedList = [true, false];
  int questionindex = 0;

  Future<List<Question>> loadQuestions() async {
    List<Question> questionlist = [];
    for (var i = 0; i < 100; i++) {
      if (await databaseRef
              .child("$i/text")
              .get()
              .then((value) => value.value) !=
          null) {
        List<Answer> answers = [];
        for (var j = 0; j < 4; j++) {
          if (await databaseRef
                  .child("$i/answer/$j/text")
                  .get()
                  .then((value) => value.value) !=
              null) {
            print(await databaseRef
                .child("$i/answer/$j/text")
                .get()
                .then((value) => value.value.toString()));
            answers.add(Answer(
                await databaseRef
                    .child("$i/answer/$j/correct")
                    .get()
                    .then((value) => value.value) as bool,
                await databaseRef
                    .child("$i/answer/$j/text")
                    .get()
                    .then((value) => value.value.toString())));
          } else {
            break;
          }
        }
        questionlist.add(Question(
            await databaseRef
                .child("$i/text")
                .get()
                .then((value) => value.value.toString()),
            answers));
      } else {
        break;
      }
    }
    print(questionlist[0].answers.length);

    return questionlist;
  }

  void toggleIsSelected(int index) {
    if (index == 0) {
      isSelectedList[index] = !isSelectedList[index];
      isSelectedList[index + 1] = !isSelectedList[index + 1];
    } else {
      isSelectedList[index] = !isSelectedList[index];
      isSelectedList[index - 1] = !isSelectedList[index - 1];
    }
  }
}
