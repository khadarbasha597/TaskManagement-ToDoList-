import 'package:flutter/material.dart';
import 'package:mini_p/pages/loginpage.dart';

import 'registerpage.dart';
class authpage extends StatefulWidget {
  const authpage({super.key});

  @override
  State<authpage> createState() => _authpageState();
}

class _authpageState extends State<authpage> {
  bool lpage =true;
  void toggleScreens(){
    setState(() {
      lpage=!lpage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(lpage){
      return loginpage(Rpage:toggleScreens,);
    }else{
      return registerpage(lpage: toggleScreens,);
    }
  }
}
