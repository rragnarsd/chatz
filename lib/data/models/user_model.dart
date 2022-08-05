class UserModel {
  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.imgUrl,
  });

  String uid;
  String name;
  String email;
  String imgUrl;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      imgUrl: json['imgUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'email': email,
        'imgUrl': imgUrl,
      };
}
