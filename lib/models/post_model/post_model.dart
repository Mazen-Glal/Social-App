class PostModel{
  late String? name;
  late String? uId;
  late String? dateTime;
  late String? text;
  late String? postImage;
  late String? image;
  late int? likes;

  PostModel({
    this.name,
    this.uId,
    this.dateTime,
    this.text,
    this.postImage,
    this.image,
    this.likes
  });


  PostModel.fromJson(Map<String,dynamic> json){
    name = json['name'];
    uId = json['uId'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];
    image = json['image'];
    likes = json['likes'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name'      :name,
      'uId'       :uId,
      'dateTime'     :dateTime,
      'text'       :text,
      'postImage' : postImage,
      'image' : image,
      'likes' : likes
    };
  }
}