import 'package:fire/pages/signup_page.dart';
import 'package:fire/service/auth_service.dart';
import 'package:fire/service/prefs_service.dart';
import 'package:fire/service/utils_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

class SignIn extends StatefulWidget{
  static const String id='signin_page';
  @override
  _SignInState createState()=>_SignInState();
}
class _SignInState extends State<SignIn>{
  bool isLoading=false;
  var emailController=new TextEditingController();
  var passController=new TextEditingController();

  _doSignIn()async{
    String email=emailController.text.toString().trim();
    String password=passController.text.toString().trim();
    if(email.isEmpty||password.isEmpty) return
      setState((){
        isLoading=true;
      });
    AuthService.signInUser(context,email,password).then((firebaseUser) =>{_getFirebaseUser(firebaseUser),});
    await Navigator.pushReplacementNamed(context,HomePage.id);
  }

  void _getFirebaseUser(FirebaseUser firebaseUser)async{
    setState((){ isLoading=false; });
    if(firebaseUser!=null){
      await Prefs.saveUserId(firebaseUser.uid);
      Navigator.pushReplacementNamed(context, HomePage.id);
      Utils.fireToast('succesfully sign in user!');
    }else{
      Utils.fireToast('check your email or password');
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:SafeArea(
        child:Stack(
          children:[
            Container(
              padding:EdgeInsets.all(20),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  //#email
                  TextField(
                    controller: emailController,
                    decoration:InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  SizedBox(height: 10,),
                  //#password
                  TextField(
                    controller: passController,
                    obscureText: true,
                    decoration:InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 45,
                    width: double.infinity,
                    child:RaisedButton(
                      elevation: 10.0,
                      shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: _doSignIn,
                      child:Text('SignIn',style:Theme.of(context).textTheme.button),
                      color:Colors.blue,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Don\'t have an account? ',style:Theme.of(context).textTheme.bodyText1),
                      GestureDetector(child:Text('SignUp',style:Theme.of(context).textTheme.bodyText2,),onTap: (){
                        Navigator.pushNamed(context,SignUp.id);
                      },)
                    ],
                  ),
                ],
              ),
            ),
            isLoading?Center(
              child:CircularProgressIndicator(),
            ):SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}