
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class updatepage extends StatefulWidget {
  final String Etime;
  updatepage({super.key,required this.Etime});

  @override
  State<updatepage> createState() => _updatepage();
}

class _updatepage extends State<updatepage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _title=TextEditingController();
  TextEditingController _stitle=TextEditingController();
  TextEditingController _description=TextEditingController();

  void fetchExistingData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user = auth.currentUser!;
    String uid = user.uid;
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      await FirebaseFirestore.instance.collection(uid).doc(widget.Etime).get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data()!;
        setState(() {
          _title.text = data['title'] ?? '';
          _stitle.text = data['subtitle'] ?? '';
          _description.text=data['description']??'';
          //time.toString()=data['time']??'';
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }


  void updateData() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      User user = auth.currentUser!;
      String uid = user.uid;
    try {
      var time=DateTime.now();
      await FirebaseFirestore.instance.collection(uid).doc(widget.Etime).update({
        'title': _title.text,
        'subtitle': _stitle.text,
        'description':_description.text,
        'time':time.toString(),
        // Add more fields as needed
      });

      // Optionally, you can show a success message or navigate to another screen.
      print('Data updated successfully');
    } catch (e) {
      print('Error updating data: $e');
      // Handle error accordingly
    }
  }
  @override
  void initState() {
    super.initState();
    // Fetch the existing data using the document ID
    fetchExistingData();
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
            'Edit Project'
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
                padding: const EdgeInsets.only(right: 244),
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
              SizedBox(height: 20,),
              Container(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: (){
                      updateData();
                      Navigator.pop(context);
                    },
                    child:Text(
                        'Update',
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
