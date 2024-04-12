import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:serenity_u/Screens/add_notes.dart';
import 'dart:ui';

final Color buttoncolor = HexColor("FF5353");
final Color textfeildcolor = HexColor("FFD9D9");
final Color texthighlight = HexColor("D04444");
final Color bottomnavigationcolor = HexColor("C13030");
final Color bnhighlightcolor = HexColor("FBABAB");
final Color selectedbncolor = HexColor("D04444");

class notes extends StatefulWidget {
  const notes({super.key});

  @override
  State<notes> createState() => _notesState();
}

class _notesState extends State<notes> {
  late List<DocumentSnapshot> notes = [];
  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    // Get the current user's UID
    String? uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid != null) {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('notes')
          .where('uid',
              isEqualTo:
                  uid) // Filter documents where uid matches current user's uid
          .get();

      setState(() {
        notes = snapshot.docs;
        print('fetched notes: $notes');
      });
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Padding(
            padding: const EdgeInsets.only(left: 30.0,top: 35.0), // Add left padding
            child: Text(
              "Notes",
              style: GoogleFonts.gentiumBookPlus(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 40,
              ),
            ),
          ),
         /*Padding(
            padding: const EdgeInsets.only(left: 30.0,), // Add left padding
            child: Text(
              "your Notes",
              style: GoogleFonts.gentiumBookPlus(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 40,
                height: 0.8
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0,), // Add left padding
            child: Text(
              "Here",
              style: GoogleFonts.gentiumBookPlus(
                color: buttoncolor,
                fontWeight: FontWeight.w400,
                fontSize: 55,
              ),
            ),
          ), */
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index].data() as Map<String, dynamic>;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoteDetailsScreen(note: note),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          bnhighlightcolor,
                          bnhighlightcolor,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 200, 200, 200),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0), // Add left padding
                              child: Text(
                                "${note['title']}",
                                style: GoogleFonts.gentiumBookPlus(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${note['date']}",
                              style: GoogleFonts.gentiumBookPlus(
                                fontSize: 20,
                                color: HexColor("D10000"),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${note['time']}",
                              style: GoogleFonts.gentiumBookPlus(
                                fontSize: 20,
                                color: HexColor("D10000"),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => addNotes()),
                  );
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
                    'Add',
                    style: GoogleFonts.itim(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.8
                    ),
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
                  color:
                  _currentIndex == 0 ? HexColor("FFAA86") : Colors.white),
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
                  color:
                  _currentIndex == 1 ? HexColor("FFAA86") : Colors.white),
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
                  color:
                  _currentIndex == 2 ? HexColor("FFAA86") : Colors.white),
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
                  color:
                  _currentIndex == 3 ? HexColor("FFAA86"): Colors.white),
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
      // Your BottomNavigationBar implementation
    );
  }
}










///NoteDetails screen
class NoteDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> note;

  const NoteDetailsScreen({Key? key, required this.note}) : super(key: key);

  @override
  _NoteDetailsScreenState createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {
  late TextEditingController _textEditingController;
  late TextEditingController titleEditController;

  /// Update Function
  Future<void> _updateNotes(String dId, String newNotes, String title) async {
    try {
      // Query for the document with matching 'dId'
      var querySnapshot = await FirebaseFirestore.instance
          .collection('notes')
          .where('dId', isEqualTo: dId)
          .get();
      print('fetched collection,$querySnapshot');
      DateTime now = DateTime.now();
      String date = "${now.year}-${now.month}-${now.day}";
      String time = "${now.hour}:${now.minute}:${now.second}";

      // Iterate through the matching documents and update the fields
      querySnapshot.docs.forEach((doc) async {
        // Get the reference to the document
        var docRef = FirebaseFirestore.instance.collection('notes').doc(doc.id);

        // Update the fields
        await docRef.update({
          'title': title,
          'notes': newNotes,
          'date': date,
          'time': time,
        });

        // Success message
        Fluttertoast.showToast(
          msg: 'Notes added successfully.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        // Navigate back to notes screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => notes()),
        );
        // Handle success
        print('Notes updated successfully');
      });
    } catch (error) {
      // Handle error
      print('Failed to update notes: $error');
      // Show error message
      Fluttertoast.showToast(
        msg: 'Failed to update notes: $error',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  ///Delete Note
  Future<void> _deleteNote(String dId) async {
    try {
      // Query for the document with matching 'dId'
      var querySnapshot = await FirebaseFirestore.instance
          .collection('notes')
          .where('dId', isEqualTo: dId)
          .get();

      // Iterate through the matching documents and delete them
      querySnapshot.docs.forEach((doc) async {
        // Get the reference to the document
        var docRef = FirebaseFirestore.instance.collection('notes').doc(doc.id);

        // Delete the document
        await docRef.delete();

        Fluttertoast.showToast(
          msg: 'Note Deleted',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => notes()),
        );
      });
    } catch (error) {
      // Handle error
      print('Failed to delete note: $error');
      // Show error message
      Fluttertoast.showToast(
        msg: 'Failed to delete note: $error',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.note['notes']);
    titleEditController = TextEditingController(text: widget.note['title']);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
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
              color: HexColor("FBABAB").withOpacity(0.5),
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.08,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 243, 220),
                  borderRadius: BorderRadius.circular(20),
                  // border: Border(
                  //     bottom: BorderSide(color: Colors.black, width: 4)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 250, 211, 211),
                      offset: Offset(0, 4),
                      blurRadius: 4,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0,top:5.0),
                  child: TextField(
                    controller: titleEditController,
                    // focusNode: _focusNode,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none, // Remove border
                      hintText: "Title", // Set empty hintText
                    ),
                    cursorColor: Colors.black,
                    textAlign: TextAlign.start,
                    // Set text alignment to start
                    style: GoogleFonts.gentiumBookPlus(
                      fontSize: 28,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      // letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.55,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 243, 220),
                  borderRadius: BorderRadius.circular(20),
                  
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 255, 233, 233),
                      offset: Offset(0, 4),
                      blurRadius: 4,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: TextField(
                      controller: _textEditingController,
                      readOnly: false,
                      textAlignVertical: TextAlignVertical.top,
                      maxLines: null,
                      style: GoogleFonts.gentiumBookPlus(
                        fontSize: 22,
                        color: HexColor("AA0000"),
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none, // Remove bottom border
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            // Add spacing between the container and buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  onPressed: () {
                    String dId = widget.note['dId'];
                    print("documentid,$dId");
                    _updateNotes(dId, _textEditingController.text,
                        titleEditController.text);
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
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.8
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.info,
                    size: 40,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'To edit, tap your notes and make changes.',
                          selectionColor: Colors.amber,
                        ), // Your message here
                      ),
                    );
                  },
                ),
                MaterialButton(
                  onPressed: () {
                    // Add your button press logic here
                    String dId = widget.note['dId'];
                    _deleteNote(dId);
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
                      'Delete',
                      style: GoogleFonts.itim(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.8
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: bottomnavigationcolor,
        selectedItemColor: HexColor("FFAA86"),
        unselectedItemColor: Colors.white,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        selectedLabelStyle: TextStyle(color: HexColor("FFAA86")),
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
                color: HexColor("FBABAB").withOpacity(0.2),
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
              child: Icon(Icons.history_rounded, color: Colors.white),
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
