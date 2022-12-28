class CreateUserModel{
  late String name;
  late String email;
  late String phone;
  late String uId;

  CreateUserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uId
  });

  CreateUserModel.fromJson(Map<String,dynamic>json){
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
  }

  Map<String,dynamic> toMap(){
    return {
      email :'email',
      name :'name',
      phone :'phone',
      uId :'uId'
    };
  }
}