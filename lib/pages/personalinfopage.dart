import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class personalinfopage extends StatefulWidget {
  const personalinfopage({super.key});

  @override
  State<personalinfopage> createState() => _personalinfopageState();
}

class _personalinfopageState extends State<personalinfopage> {
  Future<Map<String, dynamic>> getUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    User? user = auth.currentUser;

    if (user != null) {
      DocumentSnapshot userSnapshot = await firestore.collection('users').doc(user.uid).get();

      if (userSnapshot.exists) {
        return userSnapshot.data() as Map<String, dynamic>;
      }
    }

    // Return an empty map if user not found or data doesn't exist
    return {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        toolbarHeight: 60,
        elevation: 0,
        title: Text(
          'Personal Information',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: FutureBuilder(
        future: getUserData(),
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()
            ); // Loading indicator while fetching data
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            Map<String, dynamic> userData = snapshot.data ?? {};
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      'Name: ${userData['first name']} ${userData['last name']}',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                      'Age: ${userData['age']}',
                    style: GoogleFonts.aBeeZee(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Email: ${userData['email']}',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Add more fields as needed
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
