import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../videos/videourls.dart';
import 'dart:ui';

final Color buttoncolor = HexColor("FF5353");
final Color textfeildcolor = HexColor("FFD9D9");
final Color texthighlight = HexColor("D04444");
final Color bottomnavigationcolor = HexColor("C13030");
final Color bnhighlightcolor = HexColor("FBABAB");
final Color selectedbncolor = HexColor("D04444");



class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> questions;
  int currentQuestionIndex = 0;
  int selectedValue = 0;
  late Interpreter _interpreter;
  int _currentIndex = 0;

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
    _currentAnxiety();
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

  ///Define a function to load videos based on the current anxiety score
  Future<void> _loadVideos() async {
    if (currentAnxiety != null) {
      int anxietyScore = currentAnxiety!.toInt();
      print('changes$anxietyScore');
      // Instantiate an object of the VideoUtils class
      VideoUtils videoUtils = VideoUtils();
      // Call the getVideosForAnxietyScore method on the object
      List<String> videos =
          videoUtils.getVideosForAnxietyScore(anxietyScore).cast<String>();
      setState(() {
        videoUrls = videos.cast<List<String>>();
      });
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
      print('answer saved to database');
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

  ///open dialog box for anxiety detection questions
  Future<void> _checkAnxiety() async {
    // String? userId = FirebaseAuth.instance.currentUser?.uid;
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                HexColor("FFAA86"),
                HexColor("FFAA86"),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: HexColor("FFAA86")),
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
                      fontSize: 23,
                      color: bottomnavigationcolor,
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
                        selectedValue = 1;
                      });
                      print('selected answer value,$selectedValue');
                      await saveAnswer(selectedValue);
                      print(
                          'Question index,$currentQuestionIndex'); // Set value to 2 for "Yes"
                      currentQuestionIndex++;
                      print('Incremented Question index,$currentQuestionIndex');
                      Navigator.pop(context);
                      if (currentQuestionIndex < questions.length) {
                        _checkAnxiety(); // Show the next question
                      } else {
                        await predict();
                        questionIds.clear();
                        answers.clear();
                        await _currentAnxiety();
                        // await fetchDataAndPredict();
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
                        selectedValue = 0;
                      });
                      print('selected answer value,$selectedValue');
                      await saveAnswer(selectedValue);
                      print(
                          'Question index,$currentQuestionIndex'); // Set value to 2 for "Yes"
                      currentQuestionIndex++;
                      print('Incremented Question index,$currentQuestionIndex');
                      Navigator.pop(context);
                      if (currentQuestionIndex < questions.length) {
                        _checkAnxiety(); // Show the next question
                      } else {
                        await predict();
                        questionIds.clear();
                        answers.clear();
                        await _currentAnxiety();
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
                        selectedValue = 2;
                      });
                      print('selected answer value,$selectedValue');
                      await saveAnswer(selectedValue);
                      print(
                          'Question index,$currentQuestionIndex'); // Set value to 2 for "Yes"
                      currentQuestionIndex++;
                      print('Incremented Question index,$currentQuestionIndex');
                      Navigator.pop(context);
                      if (currentQuestionIndex < questions.length) {
                        _checkAnxiety(); // Show the next question
                      } else {
                        await predict();
                        questionIds.clear();
                        answers.clear();
                        await _currentAnxiety();
                        // await fetchDataAndPredict();
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
        );
      },
    );
  }

  ///find the current Anxiety
  Future<void> _currentAnxiety() async {
    // Get the current user's UID
    String? uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid != null) {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance
          .collection('answers_collection')
          .where('uid', isEqualTo: uid)
          .orderBy('date', descending: true)
          .orderBy('time', descending: true)
          .limit(1)
          .get();
      if (snapshot.docs.isNotEmpty) {
        final latestEntry = snapshot.docs.first;
        final anxietyPrediction = latestEntry['prediction'][0] as double;
        setState(() {
          currentAnxiety = anxietyPrediction.round().toDouble();
          print('Fetched current anxiety: $currentAnxiety');
        });
        // Call _loadVideos after setting state
        _loadVideos();
      } else {
        setState(() {
          currentAnxiety = null;
        });
        print('No anxiety entry found for the user.');
      }
    } else {
      print('User is not logged in.');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("FFF8EF"),
      appBar: AppBar(
        backgroundColor: buttoncolor,
        elevation: 8,
        // Remove the elevation
        leading: Padding(
          padding:
              const EdgeInsets.only(left: 10.0, top: 5, bottom: 5, right: 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/app_icon/icon.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
        title: Text(
          'Serenity-U',
          style: GoogleFonts.jomolhari(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.normal,
            letterSpacing: 1.5,
          ),
        ),
        
        actions: [
        Container(
          margin: EdgeInsets.only(right: 10.0,bottom: 05),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: bnhighlightcolor.withOpacity(0.5),
          ),
          child: IconButton(
            icon: Icon(Icons.logout,color: Colors.black),
            onPressed: () async {
              // Add your logout logic here
              try {
                await FirebaseAuth.instance.signOut();
                // Navigate to the login screen or any other screen as needed
                // Example:
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              } catch (e) {
                // Handle any errors that occur during logout
                print('Error during logout: $e');
                // Optionally, show a toast or error message to the user
                Fluttertoast.showToast(msg: 'Error logging out');
              }
            },
            // color: HexColor("745F97"),
          ),
        ),
      ],

        // Add elevation for shadow effect
        shadowColor: Colors.black.withOpacity(0.9),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //SizedBox(
            //  height: MediaQuery.of(context).size.height * 0.05,
            //),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      buttoncolor,
                      HexColor("FF8753"),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                   borderRadius: BorderRadius.only( // 0.0 for no radius, adjust as needed
      bottomLeft: Radius.circular(100.0),// 0.0 for no radius, adjust as needed
    ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey, // Shadow color
                      offset: Offset(-4, -4), // Vertical offset
                      blurRadius: 4,
                      spreadRadius: 0, // Blur radius
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Your',
                      style: GoogleFonts.gentiumBookPlus(
                        fontSize: 35,
                        color: Colors.white,
                        letterSpacing: 1.5,
                        height: 0.8,
                      ),
                    ),
                    Text(
                      'Anxiety Score',
                      style: GoogleFonts.gentiumBookPlus(
                        fontSize: 40,
                        height: 0.8,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                      
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.60,
                      height: MediaQuery.of(context).size.height * 0.15,
                      decoration: BoxDecoration(
                        color: HexColor("FFFFFF").withOpacity(0),
                        borderRadius: BorderRadius.circular(20),
                        
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0), // Shadow color
                            offset: Offset(
                              4,
                              4,
                            ), // Vertical offset
                            blurRadius: 4,
                            spreadRadius: 0, // Blur radius
                          ),
                        ],
                      ),
                      child: Center(
                        child: currentAnxiety == null
                            ? CircularProgressIndicator() // Show loading indicator
                            : Text(
                          '${currentAnxiety?.toStringAsFixed(0) ?? "N/A"}',
                          style: GoogleFonts.gentiumBookPlus(
                            fontSize: 130,
                            height: 0.8,
                            color: textfeildcolor,
                            letterSpacing: 1.5,
                            
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Anxiety score is out of 50',
                          style: GoogleFonts.gentiumBookPlus(
                              fontSize: 20,
                              height: 0.8,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(121, 23, 7, 7)),
                        ),
                      ),
                    MaterialButton(
                      onPressed: () async {
                        // Add your button press logic here
                        setState(() {
                          currentQuestionIndex = 0;
                        });
                        await _checkAnxiety();
                      },
                      color: bottomnavigationcolor,
                      elevation: 5,
                      // Adjust the elevation for box shadow
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      height: 30,
                      // Adjust the height of the button
                      minWidth: 125,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Check',
                          style: GoogleFonts.gentiumBookPlus(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                // Set to NeverScrollableScrollPhysics() if you don't want the ListView to be scrollable itself
                scrollDirection: Axis.vertical,
                itemCount: videoUrls.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.10,
                      height: MediaQuery.of(context).size.height * 0.50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            HexColor("F4F2F2"),
                            HexColor("F4F2F2"),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey, // Shadow color
                            offset: Offset(
                              4,
                              4,
                            ), // Vertical offset
                            blurRadius: 4,
                            spreadRadius: 0, // Blur radius
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                            child: Text(
                              videoUrls[index][1], // Header
                              style: GoogleFonts.jomolhari(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 35, horizontal: 20),
                            // Adjust margins as needed
                            decoration: BoxDecoration(
                              color: Colors.white,
                              // Set container background color
                              borderRadius: BorderRadius.circular(15),
                              // Apply border radius
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: YoutubePlayer(
                                controller: YoutubePlayerController(
                                  initialVideoId: YoutubePlayer.convertUrlToId(
                                      videoUrls[index][0])!,
                                  flags: YoutubePlayerFlags(
                                    autoPlay: false,
                                    mute: false,
                                  ),
                                ),
                                showVideoProgressIndicator: false,
                                progressIndicatorColor: Colors.amber,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.10,
            ),
          ],
        ),
      ),// Empty container, remove all previous content
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: bottomnavigationcolor,
        selectedItemColor: HexColor("FFAA86"),
        unselectedItemColor: Colors.white,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        selectedLabelStyle: TextStyle(color: HexColor("FFAA86")),
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: HexColor("#D8E8E8").withOpacity(0.2),
              ),
              padding: EdgeInsets.all(10),
              child: Icon(Icons.home,
                  color: _currentIndex == 0 ? HexColor("FFAA86"): Colors.white),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: HexColor("#D8E8E8").withOpacity(0.2),
              ),
              padding: EdgeInsets.all(10),
              child: Icon(Icons.note_alt_sharp,
                  color: _currentIndex == 1 ? HexColor("FFAA86") : Colors.white),
            ),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: HexColor("#D8E8E8").withOpacity(0.2),
              ),
              padding: EdgeInsets.all(10),
              child: Icon(Icons.auto_graph_sharp,
                  color: _currentIndex == 2 ? HexColor("FFAA86") : Colors.white),
            ),
            label: 'Graph',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: HexColor("#D8E8E8").withOpacity(0.2),
              ),
              padding: EdgeInsets.all(10),
              child: Icon(Icons.history_rounded,
                  color: _currentIndex == 3 ? HexColor("FFAA86") : Colors.white),
            ),
            label: 'History',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the current index
          });
          // Handle the tap event for the selected item.
          if (index == 0) {
            // Navigate to the home page.
            Navigator.pushNamed(
              context,
              '/home',
            );
          }
          if (index == 1) {
            // Navigate to the Notes page.
            Navigator.pushNamed(context, '/notes',);
          }
          if (index == 2) {
            // Navigate to the Graph page.
            Navigator.pushNamed(context, '/graph'); // Corrected route name
          }
          if (index == 3) {
            // Navigate to the History page.
            Navigator.pushNamed(context, '/history');
          }
        },
      ),
    );
  }
}
