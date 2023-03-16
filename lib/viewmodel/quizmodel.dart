import 'package:firebase_database/firebase_database.dart';
import 'package:flutterquizapp/model/answer.dart';
import 'package:flutterquizapp/model/question.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizModel {
  final databaseRef = FirebaseDatabase.instance.ref().child("questions");
  List<bool> isSelectedList = [true, false];
  int questionindex = 0;
  int isSelectedIndex = 0;
  bool loadingQuestions = false;

  Future<bool> checkSavedQuestions() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getStringList("questionlist") == null;
  }

  Future<int> getQuestListLength() async {
    int questionListLength = 0;
    await databaseRef.once().then((snapshot) {
      var data = snapshot.snapshot;
      questionListLength = data.children.length;
    });
    return questionListLength;
  }

  Future<List<Question>?> loadQuestions() async {
    final prefs = await SharedPreferences.getInstance();
    List<Question>? questionlist = [];
    int questionListLength = await getQuestListLength();

    if (await checkSavedQuestions()) {
      for (var i = 0; i < questionListLength; i++) {
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
          print(questionlist[i].text);
        } else {
          throw Exception("Fehler beim herunterladen der Fragen");
        }
      }

      await prefs.setStringList(
          "questionlist", questionlist.map((q) => q.toJson()).toList());
    } else {
      List<String>? questionStringList = prefs.getStringList('questionlist');
      questionlist =
          questionStringList?.map((q) => Question.fromJson(q)).toList();
    }

    return questionlist;
  }

  void toggleIsSelected(int index) {
    isSelectedIndex = index;
    var tmp = isSelectedList[index];
    for (var i = 0; i < isSelectedList.length; i++) {
      isSelectedList[i] = false;
    }
    isSelectedList[index] = !tmp;
    if (isSelectedList[0] == false && isSelectedList[1] == false) {
      isSelectedList[0] = true;
    }
  }

  void increaseQuestionIndex() {
    questionindex++;
  }

  void resetQuestionIndex() {
    questionindex = 0;
  }
}
