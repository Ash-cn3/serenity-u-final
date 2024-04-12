import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'homepage.dart';
import 'dart:ui';


class newUserAnxiety extends StatefulWidget {
  const newUserAnxiety({super.key});

  @override
  State<newUserAnxiety> createState() => _newUserAnxietyState();
}

class _newUserAnxietyState extends State<newUserAnxiety> {
  int currentQuestionIndex = 0;
  int selectedValue = 0;
  late Interpreter _interpreter;
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> questions;
  bool questionValue = false;

  /// List to store question IDs
  List<String> questionIds = [];

  /// List to store answers
  List<int> answers = [];
  double? currentAnxiety;
  double? Anxiety;

  List<List<String>> videoUrls = []; // Declare a list to store video URLs

  ///initial stage
  @override
  void initState() {
    super.initState();
    fetchQuestions();
    loadModel();
  }

  ///Load model File
  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/model.tflite');
      print('Model loaded successfully');
    } catch (e) {
      print('Failed to load model: $e');
    }
  }

  Future<void> predict() async {
    // For ex: if input tensor shape [1,5] and type is float32
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance
            .collection('users_collection')
            .doc(userId)
            .get();

    if (userSnapshot.exists) {
      int gender = userSnapshot['gender'];
      int age = userSnapshot['age'];

      // Ensure that age and gender are inserted at the beginning of the answers list
      answers.insert(0, age);
      answers.insert(0, gender);
      print(answers);
      var input = [answers].reshape([1, 12]);

      print(input);
      // if output tensor shape [1,2] and type is float32
      var output = List.filled(1 * 1, 0).reshape([1, 1]);

      // inference
      _interpreter.run(input, output);

      // print the output

      print(output);
      List<dynamic> predicted_anxiety =
          output[0]; // Extract the list from the output

      double value =
          predicted_anxiety[0]; // Extract the double value from the list

      print('current prediction: $value');

      _saveAnswersToDatabase(predicted_anxiety);
    }
  }

  ///function for save answers to database
  Future<void> _saveAnswersToDatabase(List<dynamic> predicted_anxiety) async {
    try {
      // Get current user ID
      String? uid = FirebaseAuth.instance.currentUser?.uid;

      // Get current date and time
      DateTime now = DateTime.now();
      String date = "${now.year}-${now.month}-${now.day}";
      String time = "${now.hour}:${now.minute}:${now.second}";
      Iterable<dynamic> Anxiety = predicted_anxiety
          .cast<dynamic>(); // Convert List<double> to Iterable<dynamic>
      print(Anxiety);

      // Add notes to Firestore
      await FirebaseFirestore.instance.collection('answers_collection').add({
        'uid': uid,
        'date': date,
        'time': time,
        'Q1': answers[2],
        'Q2': answers[3],
        'Q8': answers[4],
        'Q11': answers[5],
        'Q18': answers[6],
        'Q23': answers[7],
        'Q27': answers[8],
        'Q29': answers[9],
        'Q31': answers[10],
        'Q41': answers[11],
        'prediction': Anxiety,
      });
      print('answer added successfully');
    } catch (error) {
      // Error message
      print('Failed to add answer: $error');
    }
  }

  ///fetch all questions from database
  Future<void> fetchQuestions() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('daily_questions').get();
    setState(() {
      questions = snapshot.docs;
      questionValue = true;
      print("Questions,$questions");
    });
  }

  ///Add each answer and questions to corresponded Lists
  Future<void> saveAnswer(int answer) async {
    try {
      // Get the current question ID
      String currentQuestionId = questions[currentQuestionIndex]['Qid'];
      // Save question ID and answer to lists
      questionIds.add(currentQuestionId);
      answers.add(answer);
      print('Answer saved successfully.');
    } catch (error) {
      print('Error saving answer: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (questionValue) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.35,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: HexColor("FDF8EB"),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(45.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Unveil Your ",
                        style: GoogleFonts.gentiumBookPlus(
                          fontSize: 28,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        "Tranquil ",
                        style: GoogleFonts.gentiumBookPlus(
                          fontSize: 28,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        "Journey",
                        style: GoogleFonts.jomolhari(
                          fontSize: 40,
                          color: HexColor("CFAA61"),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.70,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      buttoncolor,
                      HexColor("FF8753"),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(color: HexColor("FEC89A")),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          questions[currentQuestionIndex]['Qns'],
                          style: GoogleFonts.jomolhari(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                          onPressed: () async {
                            setState(() {
                              selectedValue = 2;
                            });
                            print('selected answer value,$selectedValue');
                            await saveAnswer(selectedValue);
                            print(
                                'Question index,$currentQuestionIndex'); // Set value to 2 for "Yes"
                            // currentQuestionIndex++;
                            print(
                                'Incremented Question index,$currentQuestionIndex');

                            // Inside onPressed for the "None" button
                            if (currentQuestionIndex + 1 < questions.length) {
                              // Show the next question
                              currentQuestionIndex++;
                            } else {
                              // Navigate to the home page or perform other actions
                              await predict();
                              questionIds.clear();
                              answers.clear();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => homepage()),
                              );
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(color: HexColor("5D30BC")),
                          ),
                          // height: 30,
                          // // Adjust the height of the button
                          // minWidth: 100,
                          child: Text(
                            "Yes",
                            style: GoogleFonts.jomolhari(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          color: bottomnavigationcolor,
                        ),
                        MaterialButton(
                          onPressed: () async {
                            setState(() {
                              selectedValue = 1;
                            });
                            print('selected answer value,$selectedValue');
                            await saveAnswer(selectedValue);
                            print(
                                'Question index,$currentQuestionIndex'); // Set value to 2 for "Yes"
                            // currentQuestionIndex++;
                            print(
                                'Incremented Question index,$currentQuestionIndex');

                            // Inside onPressed for the "None" button
                            if (currentQuestionIndex + 1 < questions.length) {
                              // Show the next question
                              currentQuestionIndex++;
                            } else {
                              // Navigate to the home page or perform other actions
                              await predict();
                              questionIds.clear();
                              answers.clear();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => homepage()),
                              );
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(color: HexColor("5D30BC")),
                          ),
                          child: Text(
                            "No",
                            style: GoogleFonts.jomolhari(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          color: bottomnavigationcolor,
                        ),
                        MaterialButton(
                          onPressed: () async {
                            setState(() {
                              selectedValue = 0;
                            });
                            print('selected answer value,$selectedValue');
                            await saveAnswer(selectedValue);
                            print(
                                'Question index,$currentQuestionIndex'); // Set value to 2 for "Yes"
                            // currentQuestionIndex++;
                            print(
                                'Incremented Question index,$currentQuestionIndex');

                            // Inside onPressed for the "None" button
                            if (currentQuestionIndex + 1 < questions.length) {
                              // Show the next question
                              currentQuestionIndex++;
                            } else {
                              // Navigate to the home page or perform other actions
                              await predict();
                              questionIds.clear();
                              answers.clear();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => homepage()),
                              );
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(color: HexColor("5D30BC")),
                          ),
                          child: Text(
                            "None",
                            style: GoogleFonts.jomolhari(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          color: bottomnavigationcolor,
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
  }
}
