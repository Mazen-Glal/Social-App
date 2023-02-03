class CreateUserModel{
  late String? name;
  late String? email;
  late String? phone;
  late String? uId;
  late String? image;
  late String? cover;
  late String? bio;
  late bool? isVerified;

  CreateUserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.image,
    this.cover,
    this.bio,
    this.isVerified
  });


  CreateUserModel.fromJson(Map<String,dynamic>? json){
    email = json!['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    isVerified = json['isVerified'];
  }

  Map<String,dynamic> toMap(){
    return {
      'email'     :email,
      'name'      :name,
      'phone'     :phone,
      'uId'       :uId,
      'image'     :image,
      'cover'     :cover,
      'bio'       :bio,
      'isVerified':isVerified
    };
  }
}