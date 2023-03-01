class UserModel{
  String? name;
  String? image;
  String? email;
  String? phone;
  String? token;
  int? id;

  UserModel({required this.name,required this.token,required this.id,required this.email,required this.image,required this.phone});

  // Named constructor
  UserModel.fromJson(Map<String,dynamic> data){
    name = data['name'];
    image = data['image'];
    token = data['token'];
    email = data['email'];
    phone = data['phone'];
    id = data['id'];
  }

}