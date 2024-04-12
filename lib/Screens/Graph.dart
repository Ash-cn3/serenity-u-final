import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:ui';

final Color buttoncolor = HexColor("FF5353");
final Color textfeildcolor = HexColor("FFD9D9");
final Color texthighlight = HexColor("D04444");
final Color bottomnavigationcolor = HexColor("C13030");
final Color bnhighlightcolor = HexColor("FBABAB");
final Color selectedbncolor = HexColor("D04444");

class graphs extends StatefulWidget {
  const graphs({Key? key}) : super(key: key);

  @override
  State<graphs> createState() => _graphsState();
}

class _graphsState extends State<graphs> {
  int _currentIndex = 2;
  List<double> anxietyLevels = []; // List to store fetched anxiety levels
  bool isLoading = true;
  List<String> dates = [];
  List<Color> gradientColors = [Colors.blue, Colors.purple];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        final querySnapshot = await FirebaseFirestore.instance
            .collection('answers_collection')
            .where('uid', isEqualTo: uid)
            .orderBy('date')
            .orderBy('time')
            .get();
        final List<double> levels = querySnapshot.docs
            .map<double>((doc) => (doc['prediction'] as List).first as double)
            .toList();
        final List<String> fetchedDates = querySnapshot.docs
            .map<String>((doc) => doc['date'] as String)
            .toList();
        setState(() {
          anxietyLevels = levels;
          dates = fetchedDates;
          isLoading = false;
        });
        print('Fetched anxiety levels: $anxietyLevels');
        print('Fetched dates: $dates');
      } else {
        print('User is not logged in.');
      }
    } catch (error) {
      print('Error fetching data: $error');
      setState(() {
        isLoading = false;
      });
    }
  }


  Widget chartToRun() {
    LabelLayoutStrategy? xContainerLabelLayoutStrategy;
    ChartData chartData;
    ChartOptions chartOptions = const ChartOptions();
    
    // Check for empty data before creating the chart
    if (anxietyLevels.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    
    
    // Example shows a mix of positive and negative data values.
    chartData = ChartData(
      dataRows: [
        anxietyLevels,
      ],
      xUserLabels: dates,
      dataRowsLegends: const [
        'Anxiety',
      ],
      chartOptions: chartOptions,
    );

    
    var lineChartContainer = LineChartTopContainer(
      chartData: chartData,
      xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
      
    );
    
    var lineChart = LineChart(
      painter: LineChartPainter(
        lineChartContainer: lineChartContainer,
        
      ),
    );
    return lineChart;
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.90,
                height: MediaQuery.of(context).size.height * 0.70,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.0),
                  borderRadius: BorderRadius.circular(20),
                  
                  
                ),
                child: chartToRun(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: HexColor("C13030"),
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
                  color: _currentIndex == 0 ? HexColor("FFAA86") : Colors.white),
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
            Navigator.pushNamed(context, '/graph');
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
