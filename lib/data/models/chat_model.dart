class ChatModel {
  ChatModel({
    //required this.uid,
    required this.title,
    required this.message,
    required this.sender,
    required this.imgUrl,
    required this.time,
  });

  //String uid;
  String title;
  String message;
  String sender;
  String imgUrl;
  DateTime time;

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      //uid: json['uid'],
      title: json['title'],
      message: json['message'],
      sender: json['sender'],
      imgUrl: json['imgUrl'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() => {
        //'uid': uid,
        'name': title,
        'email': message,
        'sender': sender,
        'imgUrl': imgUrl,
        'time': time,
      };
}
