import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serenity_u/Screens/homepage.dart';
import 'package:serenity_u/Screens/signup.dart';
import 'newuser.dart';
import 'dart:ui';

final Color buttoncolor = HexColor("FF5353");
final Color textfeildcolor = HexColor("FFD9D9");
final Color texthighlight = HexColor("D04444");

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ///function for login user with firebase cloud fire_store
  Future<void> login(String email, String password) async {
    try {
      // Sign in with email and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      Fluttertoast.showToast(
        msg: "Login success !",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 21.0,
      );

      // Check if the user has data in the answers collection
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        final QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance
            .collection('answers_collection')
            .where('uid', isEqualTo: uid)
            .limit(1)
            .get();

        if (snapshot.docs.isNotEmpty) {
          // If user has data, navigate to the homepage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => homepage()),
          );
        } else {
          // If user has no data, navigate to the new user page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => newUserAnxiety()),
          );
        }
      } else {
        // Handle the case where uid is null
        print('User is not logged in.');
      }
    } catch (e) {
      // Handle login errors
      print('Error logging in: $e');
      // Show error message to the user
      Fluttertoast.showToast(
        msg: "Login failed !",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 21.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("FDF8EB"),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            /// Background Image
            // Image.asset(
            //   'assets/images/_0a62d633-d61b-4238-98a5-e99b926d0a99.jpeg',
            //   // Replace with your background image path
            //   width: MediaQuery.of(context).size.width,
            //   height: MediaQuery.of(context).size.height,
            //   fit: BoxFit.cover,
            // ),

            SafeArea(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        
                      ),
                    ),
                  ),
                  // Center(
                  //   child: Container(
                  //     width: MediaQuery.of(context).size.width * 0.32,
                  //     height: MediaQuery.of(context).size.height * 0.14,
                  //     decoration: BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       color: Colors.white,
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.grey,
                  //           offset: Offset(0, 4),
                  //           blurRadius: 4,
                  //           spreadRadius: 0,
                  //         ),
                  //       ],
                  //     ),
                  //     child: ClipOval(
                  //       child: Image.asset(
                  //         'assets/images/man.png',
                  //         // Adjust the path accordingly
                  //         fit: BoxFit.fill,
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  Text("Login",
                      style: GoogleFonts.gentiumBookPlus(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 40)),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                      color: textfeildcolor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 203, 202, 202),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon on the left
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Icon(
                            Icons.email,
                            color: texthighlight,
                            size: 30,
                          ),
                        ),
                        // TextField in the middle
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextField(
                              controller: emailController,
                              // inputFormatters: [
                              //   FilteringTextInputFormatter.digitsOnly,
                              //   // Allow only numeric input
                              // ],
                              // keyboardType: TextInputType.number,
                              style: GoogleFonts.gentiumBookPlus(
                                fontSize: 20,
                                color: HexColor("AA0000"),
                                fontWeight: FontWeight.normal,
                              ),
                              onEditingComplete: () {
                                // Move focus to the next TextField or perform any other action
                                FocusScope.of(context).nextFocus();
                              },
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: GoogleFonts.jomolhari(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: texthighlight),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 5),
                              ),
                            ),
                          ),
                        ),
                        // Add more widgets on the right if needed
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                      color:textfeildcolor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 203, 202, 202),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon on the left
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Icon(
                            Icons.lock,
                            color:texthighlight,
                            size: 30,
                          ),
                        ),
                        // TextField in the middle
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextField(
                              controller: passwordController,
                              obscureText: true,
                              // inputFormatters: [
                              //   FilteringTextInputFormatter.digitsOnly,
                              //   // Allow only numeric input
                              // ],
                              // keyboardType: TextInputType.number,
                              style: GoogleFonts.gentiumBookPlus(
                                fontSize: 20,
                                color: HexColor("AA0000"),
                                fontWeight: FontWeight.normal,
                              ),
                              onEditingComplete: () {
                                // Move focus to the next TextField or perform any other action
                                FocusScope.of(context).nextFocus();
                              },
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: GoogleFonts.gentiumBookPlus(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: texthighlight),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 5),
                              ),
                            ),
                          ),
                        ),
                        // Add more widgets on the right if needed
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  MaterialButton(
                    onPressed: () {
                      if (emailController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please fill in email and password.'),
                          ),
                        );
                      } else {
                        // Call login function
                        login(emailController.text, passwordController.text);
                      }
                    },
                    color: buttoncolor,
                    elevation: 1,
                    // Adjust the elevation for box shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    height: 50,
                    // Adjust the height of the button
                    minWidth: 305,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Login',
                        style: GoogleFonts.itim(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.5,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",
                          style: GoogleFonts.gentiumBookPlus(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 20)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => signup()),
                          );
                        },
                        child: Text("Sign Up",
                            style: GoogleFonts.gentiumBookPlus(
                                color: HexColor("D10000"),
                                fontWeight: FontWeight.w600,
                                fontSize: 20)),
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/images/loginimage 3.png',
                    height: MediaQuery.of(context).size.height*0.39,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
