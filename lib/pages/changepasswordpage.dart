import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class changepasswordpage extends StatefulWidget {
  const changepasswordpage({super.key});

  @override
  State<changepasswordpage> createState() => _changepasswordpageState();
}

class _changepasswordpageState extends State<changepasswordpage> {
  final _newpass=TextEditingController();
  final _newpass1=TextEditingController();
  var _isObscured=true;
  var _isObscured1=true;
  Future<void> changepassword(String newPassword)async{
    User? user =FirebaseAuth.instance.currentUser;
    try{
      await user!.updatePassword(newPassword);
      print("password updated successfully");
    }catch(e){
      print("Error updating password:$e");
    }

  }
  @override
  void dispose() {
    // TODO: implement dispose
    _newpass.dispose();
    _newpass1.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        toolbarHeight: 60,
        elevation: 0,
        title: Text(
          'Change Password',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Column(
          children: [

            Text(
              'Would you like to Change the Password?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize:22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    controller: _newpass,
                    obscureText: _isObscured,
                    obscuringCharacter: '.',
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: _isObscured? Icon(Icons.visibility):Icon(Icons.visibility_off),

                        onPressed: (){
                          setState(() {
                            _isObscured =!_isObscured;
                          });
                        }
                        ,),
                      hintText: 'Password',

                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height:10,),
            //passwardtextfield
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    controller: _newpass1,
                    obscureText: _isObscured1,
                    obscuringCharacter: '.',
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: _isObscured1? Icon(Icons.visibility):Icon(Icons.visibility_off),

                        onPressed: (){
                          setState(() {
                            _isObscured1 =!_isObscured1;
                          });
                        }
                        ,),
                      hintText: 'Re-enter',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 14,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GestureDetector(
                onTap: (){
                  Fluttertoast.showToast(msg: 'Password Updated');
                  changepassword(_newpass.text);
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'Change',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
