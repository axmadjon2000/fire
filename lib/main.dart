import 'package:firebase_auth/firebase_auth.dart';
import 'package:fire/pages/detail_page.dart';
import 'package:fire/pages/home_page.dart';
import 'package:fire/pages/signin_page.dart';
import 'package:fire/pages/signup_page.dart';
import 'package:fire/service/prefs_service.dart';
import 'package:fire/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget _startPage(){
    return StreamBuilder<FirebaseUser>(
        stream:FirebaseAuth.instance.onAuthStateChanged,
        builder:(BuildContext context,snapshot){
          if(snapshot.hasData){
            Prefs.saveUserId(snapshot.data.uid);
            return HomePage();
          }else{
            Prefs.removeUserId();
            return SignIn();
          }
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:basicTheme(context),
      home:_startPage(),
      routes: {
        HomePage.id:(context)=>HomePage(),
        SignIn.id:(context)=>SignIn(),
        SignUp.id:(context)=>SignUp(),
        AddPost.id:(context)=>AddPost(),
      },
    );
  }
}


