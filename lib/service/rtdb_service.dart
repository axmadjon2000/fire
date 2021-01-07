import 'dart:convert';
import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fire/models/post_model.dart';
class RTDBService{
  static final _database=FirebaseDatabase.instance.reference();

  static Future<Stream<Event>> addPost(Post post)async{
    await _database.child("posts").push().set(post.toJson());
    return _database.onChildAdded;
  }

  static Future<List<Post>> getPost(String id) async{
    List<Post> items=new List();
    Query _query=_database.reference().child("posts").orderByChild("userId").equalTo(id);
    var snapshot=await _query.once();
    var result=Map<String,dynamic>.from(snapshot.value);
    for(var item in result.keys){
      items.add(Post.fromJson(Map<String,dynamic>.from(result[item])));
    }
    return items;
  }
}