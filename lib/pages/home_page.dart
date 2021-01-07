import 'package:fire/models/post_model.dart';
import 'package:fire/pages/signin_page.dart';
import 'package:fire/service/auth_service.dart';
import 'package:fire/service/prefs_service.dart';
import 'package:fire/service/rtdb_service.dart';
import 'package:flutter/material.dart';
import 'detail_page.dart';
class HomePage extends StatefulWidget {
  static const String id='home_page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Post> _lt=new List();
  @override
  void initState(){
    super.initState();
    _apiGetPosts();
  }
  Future _openDetail()async{
    var result=await Navigator.of(context).push(new MaterialPageRoute(
      builder:(BuildContext context){
        return new AddPost();
      }));
     if(result!=null && result.containsKey('data')){
       _apiGetPosts();
   }
  }
  _apiGetPosts()async{
    var id=await Prefs.loadUserId();
    RTDBService.getPost(id).then((posts)=>_loadPosts(posts)).catchError((err)=>print('THIS IS ERROR:::$err'));
  }

  _loadPosts(posts)async{
    setState((){
      _lt=posts.toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        leading: Container(),
        title:Text('Home',style:Theme.of(context).textTheme.headline6.copyWith(
          fontSize: 25,
        )),
        centerTitle: true,
        actions:[
          IconButton(
            icon:Icon(Icons.logout),
            onPressed:()async{
              await AuthService.signOutUser(context);
            },
          ),
        ],
      ),
      body:SafeArea(
        child:ListView.builder(
          itemCount: _lt.length,
          itemBuilder: (BuildContext context,index){
            return itemsOfList(_lt[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:()async{
          await _openDetail();
        },
        child:Icon(Icons.add),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
    );
  }
  Container itemsOfList(Post post){
    return Container(
      padding:EdgeInsets.all(20),
      child:Column(
        children:[
          Container(
            width:double.infinity,
            child:RichText(
                textAlign: TextAlign.start,
                text:TextSpan(
                  text:'${post.title}\n',
                  style:TextStyle(color: Colors.black,fontSize: 30),
                  children:[
                    TextSpan(text:'${post.content}' ,style:TextStyle(fontSize: 20)),
                  ],
                )
            ),
          ),
        ],
      ),
    );
  }
}
