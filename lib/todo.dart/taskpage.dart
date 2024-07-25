
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_p/todo.dart/work.dart';

import '../sample.dart';
class taskpage extends StatefulWidget {
  taskpage({super.key,});

  @override
  State<taskpage> createState() => _taskpageState();
}

class _taskpageState extends State<taskpage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _title=TextEditingController();
  TextEditingController _stitle=TextEditingController();
  TextEditingController _description=TextEditingController();

  addtasktofirebase()async{
    var time=DateTime.now();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    User user = auth.currentUser!;
    String uid = user.uid;
    CollectionReference users = firestore.collection(uid);
    await users.add({
      'title':_title.text,
      'subtitle':_stitle.text,
      'time': time.toString(),
      'description':_description.text,
    });
    Fluttertoast.showToast(msg: 'Data added');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        toolbarHeight: 60,
        elevation: 0,
        title: Padding(
        padding: const EdgeInsets.only(left: 15),
    child: Text(
      'Add Project'
      ,style: TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    ),
    ),
    ),
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
          children: [
            SizedBox(height: 25,),
            Container(
              child:TextField(
                controller: _title,
                decoration: InputDecoration(
                  labelText: 'Task',
                  labelStyle: TextStyle(fontSize: 20),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16,),
            Container(
              child:TextField(
                controller: _stitle,
                decoration: InputDecoration(
                  labelText: 'Sub Task',
                  labelStyle: TextStyle(fontSize: 20),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.only(right: 268),
              child: Text(
                'Description :-',
                textAlign:TextAlign.start,
                style: TextStyle(
                  fontSize: 16
                ),
              ),
            ),
            SizedBox(height: 12,),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Container(
                child:TextField(

                  controller: _description,
                  decoration: InputDecoration(
                    hintText: 'About the task',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  minLines: 5,
                ),
              ),
            ),
            SizedBox(height: 10,),
            // GestureDetector(
            //   onTap:(){
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context){
            //           return FileUploadPage();
            //         })
            //     );
            //   },
            //   child: Text(
            //       'Upload File'
            //   ),
            // ),
            SizedBox(height: 20,),
            Container(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: (){
                    addtasktofirebase();
                    Navigator.pop(context);
                  },
                  child:Text(
                    'Add',
                    style: GoogleFonts.roboto(fontSize:18)
                  )
              ),
            ),
          ],
          ),
        ),
      ),
    );
  }
}
