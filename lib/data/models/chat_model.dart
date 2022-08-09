class MessageField {
  static const String createdAt = 'createdAt';
}

class Message {
  final String uid;
  final String imgUrl;
  final String name;
  final String message;
  final DateTime createdAt;

  Message({
    required this.uid,
    required this.imgUrl,
    required this.name,
    required this.message,
    required this.createdAt,
  });

  static Message fromJson(Map<String, dynamic> json) => Message(
        uid: json['uid'],
        imgUrl: json['imgUrl'],
        name: json['name'],
        message: json['message'],
        createdAt: DateTime.parse(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'imgUrl': imgUrl,
        'name': name,
        'message': message,
        'createdAt': createdAt,
      };
}
