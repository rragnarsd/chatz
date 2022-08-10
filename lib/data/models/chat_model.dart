class MessageField {
  static const String createdAt = 'createdAt';
}

class Message {
  final String sender;
  final String receiver;
  final List<String> comp;
  final String message;
  final DateTime createdAt;

  Message({
    required this.sender,
    required this.receiver,
    required this.comp,
    required this.message,
    required this.createdAt,
  });

  static Message fromJson(Map<String, dynamic> json) => Message(
        sender: json['sender'],
        receiver: json['receiver'],
        comp: json['comp'],
        message: json['message'],
        createdAt: DateTime.parse(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'sender': sender,
        'receiver': receiver,
        'comp': comp,
        'message': message,
        'createdAt': createdAt,
      };
}
