import 'package:firebase_database/firebase_database.dart';
import 'package:flutterquizapp/model/answer.dart';
import 'package:flutterquizapp/model/question.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutterquizapp/model/category.dart';

class QuizModel {
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
  List<bool> isSelectedList = [true, false];
  int categoryCount = 0;
  int questionindex = 0;
  int categoryindex = 0;
  int isSelectedIndex = 0;
  bool loadingQuestions = false;
  String questionListPath = "questions";

  Future<bool> checkSavedQuestions(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();

    print("CHECK SAVED QUESTIONS = " +
        (prefs.getStringList("categorylist${languageCode.toUpperCase()}") ==
                null)
            .toString());

    return prefs.getStringList("categorylist${languageCode.toUpperCase()}") ==
        null;
  }

  Future<int> getQuestListLength() async {
    databaseRef = FirebaseDatabase.instance
        .ref()
        .child(questionListPath)
        .child("0")
        .child("questions");
    int questionListLength = 0;
    await databaseRef.once().then((snapshot) {
      var data = snapshot.snapshot;
      questionListLength = data.children.length;
    });
    return questionListLength;
  }

  Future<void> initCategoryCount() async {
    databaseRef = FirebaseDatabase.instance.ref().child(questionListPath);
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getInt("categorycount") == null) {
      await databaseRef.once().then((snapshot) {
        var data = snapshot.snapshot;
        int count = data.children.length;
        categoryCount = count;
        prefs.setInt("categorycount", count);
      });
    } else {
      categoryCount = prefs.getInt("categorycount")!;
    }
  }

  Future<List<Category>> loadQuestions(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    List<Category>? categorylist = [];
    List<Question>? questionlist = [];
    int questionListLength = await getQuestListLength();
    DatabaseReference dbRef =
        FirebaseDatabase.instance.ref().child(questionListPath);

    await dbRef.once().then((value) async {
      final data = value.snapshot;
      if (await checkSavedQuestions(languageCode)) {
        for (var k = 0; k < categoryCount; k++) {
          for (var i = 0; i < questionListLength; i++) {
            if (data.child("$k/questions/$i/text").value != null) {
              List<Answer> answers = [];
              for (var j = 0; j < 4; j++) {
                if (data.child("$k/questions/$i/answer/$j/text").value !=
                    null) {
                  answers.add(Answer(
                      data.child("$k/questions/$i/answer/$j/correct").value
                          as bool,
                      data
                          .child("$k/questions/$i/answer/$j/text")
                          .value
                          .toString()));
                } else {
                  break;
                }
              }
              questionlist!.add(Question(
                  data.child("$k/questions/$i/text").value.toString(),
                  answers));
              print(questionlist![i].text);
            } else {
              throw Exception("Fehler beim herunterladen der Fragen");
            }
          }
          categorylist!.add(Category(
              data.child("$k/categoryName").value.toString(), questionlist!));
          questionlist = [];
        }

        await prefs.setStringList("categorylist" + languageCode.toUpperCase(),
            categorylist!.map((e) => e.toJson()).toList());

        print("Category list filled");
      } else {
        List<String>? categoryStringList =
            prefs.getStringList('categorylist' + languageCode.toUpperCase());

        categorylist =
            categoryStringList?.map((q) => Category.fromJson(q)).toList();
      }
    });
    return categorylist!;
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

  void changeQuestionListPath(String languageTitle) {
    switch (languageTitle) {
      case "Deutsch":
        questionListPath = "questions";
        break;
      case "English":
        questionListPath = "questionsEN";
        break;
      default:
    }
  }

  void loadingQuestionsStart() async {
    loadingQuestions = true;
  }

  void loadingQuestionsCompleted() {
    loadingQuestions = false;
  }
}
