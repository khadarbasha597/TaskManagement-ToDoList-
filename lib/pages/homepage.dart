import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mini_p/pages/personalinfopage.dart';
import 'package:mini_p/todo.dart/taskpage.dart';
import 'package:mini_p/pages/updatepage.dart';
import 'changepasswordpage.dart';
import 'settingspage.dart';
class HomePage extends StatefulWidget {

  HomePage({
    super.key
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
String uid='';
bool? isChecked = false;
  @override
  void initState() {
    getuid();
    super.initState();
  }
  getuid() {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      setState(() {
        uid = user.uid;
      });
    } else {
      print("User is null. Redirecting to login screen or handling appropriately.");
      // You might want to navigate to a login screen or handle the case appropriately
    }
  }

  var time=DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
      backgroundColor: Colors.deepPurple,
      toolbarHeight: 70,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(top: 20,),
        child: Text('Projects',style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top:24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PopupMenuButton<String>(
                icon: Icon(Icons.settings,size: 25,),
                onSelected: (String result) {
                  // Handle selection from the popup menu
                  if (result == 'personalinfo'){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context){
                          return personalinfopage();
                        })
                    );
                  }
                  else if(result == 'changepasswordpage'){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context){
                          return changepasswordpage();
                        })
                    );
                  }

                  print('Selected: $result');
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'personalinfo',
                    child: Text('personalinfo'),
                  ),
                  PopupMenuItem<String>(
                    value: 'changepasswordpage',
                    child: Text('change password'),
                  ),
                  PopupMenuItem<String>(
                    value: 'Help',
                    child: Text('Help?'),
                  ),
                  // Add more PopupMenuItems as needed
                ],
              ),
              SizedBox(width: 25,),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: (){
                    FirebaseAuth.instance.signOut();
                  },
                  child: Icon(
                    Icons.logout,
                    size: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          Navigator.push(context,
              MaterialPageRoute(builder: (context){
                return taskpage();
              })
          );
        },
        child: Icon(Icons.add),
      ),
      body:  StreamBuilder(
        stream: FirebaseFirestore.instance.collection(uid).snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>?>  snapshot) {
          if (snapshot.connectionState==ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(),

            );
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot<Map<String, dynamic>> document) {
              Map<String, dynamic> data = document.data() ?? {};
              // Make sure 'name' and 'email' exist in your data
              String title = data['title'] ?? '';
              String subtitle = data['subtitle'] ?? '';
              String time1 = data['time'] ?? '';
              String documentId = document.id;

              return Padding(
                padding: const EdgeInsets.only(top: 16,left: 14,right: 12),
                child: Column(
                  children: [
                    Slidable(
                      startActionPane: ActionPane(
                        motion: StretchMotion(),
                        children: [
                          SlidableAction(
                            autoClose: true,
                            icon: Icons.edit,
                            backgroundColor: Colors.deepPurple,
                            onPressed: (context){
                              editpage(documentId);
                            },
                            borderRadius: BorderRadius.circular(10),
                          )
                        ],
                      ),
                      endActionPane: ActionPane(
                        motion: const StretchMotion(),
                        children: [
                          SlidableAction(
                            autoClose: true,
                            icon: Icons.delete,
                            backgroundColor: Colors.green,
                            onPressed: (context){
                              FirebaseFirestore.instance.collection(uid).doc(documentId).delete();
                            },
                            borderRadius: BorderRadius.circular(10),
                          )
                        ],
                      ),
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          color:  Colors.red,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(2, 2),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top:4),
                          child: ListTile(
                            title: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Container(
                                    height: 26,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(title,
                                              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                                        ),
                                        // Checkbox(
                                        //   value: isChecked,
                                        //   onChanged:(bool? newValue) {
                                        //     setState(() {
                                        //       isChecked=newValue;
                                        //     });
                                        //   },
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(left: 15,top: 4),
                              child: Text(subtitle,
                                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: 4,left: 150),
                      child: Text(
                          time1,
                        style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  void editpage(time) {
    print("Editing page with time1: $time");
    Navigator.push(context,
      MaterialPageRoute(builder: (context)=>updatepage(Etime:time)),
    );
  }

  // changed(bool? value) {
  //     setState(() {
  //       isChecked = !isChecked;
  //       if(isChecked==true){
  //         Fluttertoast.showToast(msg: ' Completed');
  //       }
  //     });
  //
  // }
}

