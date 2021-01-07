class Post{
  String userId;
  String title;
  String content;
  Post({this.userId,this.title,this.content});
  Post.fromJson(Map<String,dynamic> json):
        this.userId=json['userId'],
        this.title=json['title'],
        this.content=json['content'];
  Map<String,dynamic> toJson(){
    return {
      'userId':this.userId,
      'title':this.title,
      'content':this.content,
    };
  }
}