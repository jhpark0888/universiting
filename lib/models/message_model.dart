class Message{
  int id;
  String message;
  DateTime date;

  Message({required this.id, required this.message, required this.date});

  factory Message.fromJson(Map<String, dynamic> json) => Message(id: json['id'], message: json['message'], date: DateTime.parse(json['date']));
}