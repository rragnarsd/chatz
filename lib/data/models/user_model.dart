class UserModel {
  UserModel({
    this.uid,
    this.name,
    this.email,
    this.imgUrl,
    this.lastMessage,
  });

  String? uid;
  String? name;
  String? email;
  String? imgUrl;
  DateTime? lastMessage;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      imgUrl: json['imgUrl'],
      lastMessage: DateTime.parse(json['lastMessage']),
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'email': email,
        'imgUrl': imgUrl,
        'lastMessage': lastMessage!,
      };
}
