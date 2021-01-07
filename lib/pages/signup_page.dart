import 'package:fire/pages/signin_page.dart';
import 'package:fire/service/auth_service.dart';
import 'package:fire/service/prefs_service.dart';
import 'package:fire/service/utils_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
class SignUp extends StatefulWidget{
  static final String id='signup_page';
  _SignUpState createState(){
    return _SignUpState();
  }
}
class _SignUpState extends State<SignUp>{
  var isLoading=false;
  var fullNameController=new TextEditingController();
  var emailController=new TextEditingController();
  var passController=new TextEditingController();

  _doSignUp()async{
    String fullName=fullNameController.text.toString().trim();
    String email=emailController.text.toString().trim();
    String pass=passController.text.toString().trim();

    if(fullName.isEmpty||email.isEmpty||pass.isEmpty)return
      setState((){isLoading=true;});
    AuthService.signUpUser(context,fullName, email, pass).then((firebaseUser)=>{
      _getFirebaseUser(firebaseUser),
    });
    await Navigator.pushReplacementNamed(context,HomePage.id);
  }

  void _getFirebaseUser(FirebaseUser firebseUser)async{
    setState(() {isLoading=false;});
    if(firebseUser!=null){
      await Prefs.saveUserId(firebseUser.uid);
      Navigator.pushReplacementNamed(context, HomePage.id);
      Utils.fireToast('succesfully sign un user!');
    }else{
      Utils.fireToast('check your informations');
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:SafeArea(
        child:Stack(
          children: [
            Container(
              padding:EdgeInsets.all(20),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  //#fullName
                  TextField(
                    controller: fullNameController,
                    decoration:InputDecoration(
                      hintText: 'Full Name',
                    ),
                  ),
                  SizedBox(height: 10,),
                  //#email
                  TextField(
                    controller:emailController,
                    decoration:InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  SizedBox(height: 10,),
                  //#password
                  TextField(
                    controller:passController,
                    obscureText: true,
                    decoration:InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: double.infinity,
                    height: 45,
                    child:RaisedButton(
                      elevation: 10.0,
                      shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: _doSignUp,
                      child:Text('SignUp',style:Theme.of(context).textTheme.button),
                      color:Colors.blue,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Already have an account? ',style:Theme.of(context).textTheme.bodyText1),
                      GestureDetector(child:Text('SignIn',style:Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w400),),onTap: (){
                        Navigator.pushNamed(context, SignIn.id);
                      },)
                    ],
                  ),
                ],
              ),
            ),
            if(isLoading)Center(
              child:CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}