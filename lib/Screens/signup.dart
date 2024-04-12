import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'loginpage.dart';
import 'dart:ui';

final Color buttoncolor = HexColor("FF5353");
final Color textfeildcolor = HexColor("FFD9D9");
final Color texthighlight = HexColor("D04444");

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  String? selectedGender;
  int selectedValue = 0; // Default value
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  ///function for Register user with firebase cloud fire_store
  Future<void> signupUsers(String name, String email, String password,
      int gender, int age) async {
    try {
      // Create user with email and password
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Get user ID
      String userId = userCredential.user!.uid;

      // Store additional user data in Firestore
      await FirebaseFirestore.instance
          .collection('users_collection')
          .doc(userId)
          .set({
        'name': name,
        'email': email,
        'gender': gender,
        'age': age,
        // Add more fields as needed
      });
      print('User successfully registered with ID: $userId');
      Fluttertoast.showToast(
        msg: "signup success !",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 21.0,
      );
      // Navigate to login page after successful signup
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      // Handle signup errors
      print('Error signing up: $e');
      Fluttertoast.showToast(
        msg: "signup Failed!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("FFF8EF"),
      body: Stack(
        children: [
          // Background Image
          // Image.asset(
          //   'assets/images/_3147ae15-8be3-4a16-a16b-cef0d4fb3374.jpeg',
          //   // Replace with your background image path
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height,
          //   fit: BoxFit.cover,
          // ),
          SingleChildScrollView(
            child: SafeArea(
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
                Text("Sign-Up",
                    style: GoogleFonts.gentiumBookPlus(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 40)),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
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
                          Icons.person,
                          color: texthighlight,
                          size: 30,
                        ),
                      ),
                      // TextField in the middle
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextField(
                            controller: nameController,
                            // inputFormatters: [
                            //   FilteringTextInputFormatter.digitsOnly,
                            //   // Allow only numeric input
                            // ],
                            // keyboardType: TextInputType.number,
                            style: GoogleFonts.gentiumBookPlus(
                              fontSize: 18,
                              color: HexColor("AA0000"),
                              fontWeight: FontWeight.normal,
                            ),
                            onEditingComplete: () {
                              // Move focus to the next TextField or perform any other action
                              FocusScope.of(context).nextFocus();
                            },
                            decoration: InputDecoration(
                              labelText: 'Name',
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
                  height: MediaQuery.of(context).size.height * 0.02,
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
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                  height: MediaQuery.of(context).size.height * 0.02,
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
                          Icons.lock,
                          color: texthighlight,
                          size: 30,
                        ),
                      ),
                      // TextField in the middle
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextField(
                            obscureText: true,
                            controller: passwordController,
                            // inputFormatters: [
                            //   FilteringTextInputFormatter.digitsOnly,
                            //   // Allow only numeric input
                            // ],
                            // keyboardType: TextInputType.number,
                            style: GoogleFonts.gentiumBookPlus(
                              fontSize: 18,
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
                  height: MediaQuery.of(context).size.height * 0.02,
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
                      // Icon on the left
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Icon(
                          Icons.male,
                          color: texthighlight,
                          size: 30,
                        ),
                      ),
                      // DropdownButton in the middle
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: DropdownButtonFormField<String>(
                            value: selectedGender,
                            items:
                                ['Male', 'Female', 'Other',"Don't wish to specify"].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: GoogleFonts.gentiumBookPlus(
                                    fontSize: 20,
                                    color: HexColor("AA0000"),
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedGender = newValue!;
                                if (selectedGender == 'Male' || selectedGender == 'Female') {
                                  selectedValue = 2;
                                } else if (selectedGender == 'Other') {
                                  selectedValue = 3;
                                } else {
                                  selectedValue = 0;
                                }
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Gender',
                              labelStyle: GoogleFonts.gentiumBookPlus(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: texthighlight,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 5),
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      // Add more widgets on the right if needed
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
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
                          Icons.cake,
                          color: texthighlight,
                          size: 30,
                        ),
                      ),
                      // TextField in the middle
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextField(
                            controller: ageController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              // Allow only numeric input
                            ],
                            keyboardType: TextInputType.number,
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
                              labelText: 'Age',
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
                  height: 35,
                ),
                MaterialButton(
                  onPressed: () {
                    // Check if any required fields are empty
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty ||
                        nameController.text.isEmpty ||
                        ageController.text.isEmpty) {
                      // Display an error message or toast indicating missing information
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Please fill in all the fields')),
                      );
                      return; // Exit the function without attempting registration
                    }
                    print(
                        'sending data,${emailController.text}, ${passwordController.text}, ${nameController.text}, $selectedGender, ${ageController.text}');

                    signupUsers(
                      nameController.text,
                      emailController.text,
                      passwordController.text,
                      selectedValue,
                      int.parse(ageController.text),
                    );

                    // Clear text fields
                    emailController.clear();
                    passwordController.clear();
                    nameController.clear();
                    ageController.clear();

                    // Navigate to login page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  color: buttoncolor,
                  elevation: 5,
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
                      'Sign Up',
                      style: GoogleFonts.itim(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.5,
                          color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?",
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
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text("Login",
                          style: GoogleFonts.gentiumBookPlus(
                              color: HexColor("D10000"),
                              fontWeight: FontWeight.w600,
                              fontSize: 20)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'assets/images/signup.png',
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
