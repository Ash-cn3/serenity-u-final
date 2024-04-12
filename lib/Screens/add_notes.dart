import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:serenity_u/Screens/Notes.dart';
import 'package:uuid/uuid.dart';
import 'dart:ui';

final Color buttoncolor = HexColor("FF5353");
final Color textfeildcolor = HexColor("FFD9D9");
final Color texthighlight = HexColor("D04444");
final Color bottomnavigationcolor = HexColor("C13030");
final Color bnhighlightcolor = HexColor("FBABAB");
final Color notestextbackgroundcolor = Color.fromARGB(255, 255, 243, 220);

class addNotes extends StatefulWidget {
  const addNotes({super.key});

  @override
  State<addNotes> createState() => _addNotesState();
}

class _addNotesState extends State<addNotes> {
  late FocusNode _focusNode;
  TextEditingController newNotesController = TextEditingController();
  TextEditingController titleController =
      TextEditingController(); // Define TextEditingController for titles

  Future<void> _saveNotes(String newNotes, String title) async {
    try {
      // Get current user ID
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      // Generate a unique document ID
      String docId = Uuid().v4();
      // Get current date and time
      DateTime now = DateTime.now();
      String date = "${now.year}-${now.month}-${now.day}";
      String time = "${now.hour}:${now.minute}:${now.second}";

      // Add notes to Firestore
      await FirebaseFirestore.instance.collection('notes').add({
        'dId': docId,
        'uid': uid,
        'date': date,
        'time': time,
        'title':title,
        'notes': newNotes,
      });
      Fluttertoast.showToast(
        msg: 'Notes added successfully.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      // Success message
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => notes()),
      );
      print('Notes added successfully');

      // Clear text field after saving
      newNotesController.clear();
    } catch (error) {
      // Error message
      print('Failed to add notes: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _openKeyboard();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _openKeyboard() {
    Future.delayed(Duration.zero, () {
      FocusScope.of(context).requestFocus(_focusNode);
    });
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.80,
                    height: MediaQuery.of(context).size.height * 0.08,
                    decoration: BoxDecoration(
                      color: notestextbackgroundcolor,
                      borderRadius: BorderRadius.circular(20),
                      // border: Border(
                      //     bottom: BorderSide(color: Colors.black, width: 4)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 245, 222, 222),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0,top:5.0),
                      child: TextField(
                        controller: titleController,
                        focusNode: _focusNode,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none, // Remove border
                          hintText: "Title", // Set empty hintText
                        ),
                        cursorColor: Colors.black,
                        textAlign: TextAlign.start,
                        // Set text alignment to start
                        style: GoogleFonts.jomolhari(
                          fontSize: 25,
                          color: HexColor("AA0000"),
                          fontWeight: FontWeight.bold,
                          // letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.80,
                    height: MediaQuery.of(context).size.height * 0.80,
                    decoration: BoxDecoration(
                      color: notestextbackgroundcolor,
                      borderRadius: BorderRadius.circular(20),
                      
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 255, 236, 236),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: newNotesController,
                        
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none, // Remove border
                          hintText: "Description", // Set empty hintText
                        ),
                        cursorColor: Colors.black,
                        textAlign: TextAlign.start,
                        // Set text alignment to start
                        style: GoogleFonts.jomolhari(
                          fontSize: 20,
                          color: HexColor("AA0000"),
                          fontWeight: FontWeight.bold,
                          // letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              ],
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.05,
            right: MediaQuery.of(context).size.width * 0.08,
            child: MaterialButton(
              onPressed: () {
                if (newNotesController.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: 'Please type something...',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                } else if(titleController.text.isEmpty){
                  Fluttertoast.showToast(
                    msg: 'Please add a Title',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
                else {
                  // Call login function
                  _saveNotes(newNotesController.text,titleController.text);
                }
                // Add your button press logic here
              },
              color: buttoncolor,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              height: 30,
              minWidth: 110,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Save',
                  style: GoogleFonts.itim(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing:1.8
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: bottomnavigationcolor,
        selectedItemColor: bnhighlightcolor,
        unselectedItemColor: Colors.white,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        selectedLabelStyle: TextStyle(color: bnhighlightcolor),
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        items: [
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: HexColor("#D8E8E8").withOpacity(0.2),
              ),
              padding: EdgeInsets.all(10),
              child: Icon(Icons.home, color: Colors.white),
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
              child: Icon(Icons.note_alt_sharp, color: Colors.white),
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
              child: Icon(Icons.auto_graph_sharp, color: Colors.white),
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
              child: Icon(Icons.history_rounded, color:Colors.white),
            ),
            label: 'History',
          ),
        ],
        onTap: (index) {
          // Handle the tap event for the selected item.
          if (index == 0) {
            // Navigate to the home page.
            Navigator.pushNamed(context, '/home');
          }
          if (index == 1) {
            // Navigate to the Notes page.
            Navigator.pushNamed(context, '/notes');
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
