import 'package:flutter/material.dart';
import 'package:fire/models/post_model.dart';
import 'package:fire/service/prefs_service.dart';
import 'package:fire/service/rtdb_service.dart';
import 'home_page.dart';

class AddPost extends StatefulWidget {
  static final String id='add_post_page';
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  var titleController=new TextEditingController();
  var contentController=new TextEditingController();

  _addPost()async{
    var title =titleController.text.toString().trim();
    var content=contentController.text.toString().trim();
   _apiAddPost(title, content);
  }
  _apiAddPost(String title,String content)async{
    var id=await Prefs.loadUserId();
    var post=new Post(userId: id,title:title,content:content);
    await RTDBService.addPost(post).then((value)=>{
      _respAddPost(),
    }).catchError((err)=>print("THIS IS ERROR::$err"));
  }
  _respAddPost() {
    Navigator.of(context).pop({"data":"done"});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Add Post'),
        centerTitle: true,
        leading: IconButton(
          icon:Icon(Icons.arrow_back_ios_rounded),
          onPressed:(){
           Navigator.pop(context);
          },
          color:Colors.white,
        ),
      ),
      body:SafeArea(
        child:Container(
          padding:EdgeInsets.all(25),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children:[
              TextField(
                controller: titleController,
                decoration:InputDecoration(
                    hintText:'Title'
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: contentController,
                decoration:InputDecoration(
                    hintText:'Content'
                ),
              ),
              SizedBox(height: 15,),
              Container(
                width: double.infinity,
                height: 50,
                child:FlatButton(
                  child:Text('Add',style:Theme.of(context).textTheme.button.copyWith(
                    fontSize:16,
                  )),
                  onPressed:(){
                     _addPost();
                  },
                  color:Theme.of(context).buttonColor,
                  shape:RoundedRectangleBorder(
                    borderRadius:BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
