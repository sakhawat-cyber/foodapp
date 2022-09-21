class UserModel{
  int id;
  String name;
  String email;
  String phone;
  int oderCount;

  UserModel({
   required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.oderCount,
 });
  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      id: json["id"],
      name: json["f_name"],
      email: json["email"],
      phone: json["phone"],
      oderCount: json["order_count"]
    );
  }

}