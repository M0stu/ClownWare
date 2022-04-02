class ChatUser {
  final String uid;
  final String name;
  final String email;
  final String imageURL;
  late DateTime lastSeen;

  ChatUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.imageURL,
    required this.lastSeen,
  });

  factory ChatUser.fromJSON(Map<String, dynamic> _json) {
    return ChatUser(
      uid: _json["uid"],
      name: _json["name"],
      email: _json["email"],
      imageURL: _json["image"],
      lastSeen: _json["last_seen"].toDate(),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "name": name,
      "lastSeen": lastSeen,
      "image": imageURL,
    };
  }

  String lastDayActive() {
    return "${lastSeen.month}/${lastSeen.day}/${lastSeen.year}";
  }

  String lastTimeActive() {
    var now = new DateTime.now();
    var Time_counter = now.minute - lastSeen.minute;

    if (Time_counter < 60) {
      var Time_counter = now.minute - lastSeen.minute;
      return "Last Seen ${Time_counter} min";
    } else {
      var Time_counter = now.hour - lastSeen.hour;
      return "Last Seen ${Time_counter} hours";
    }
  }

  bool wasActive() {
    return DateTime.now().difference(lastSeen).inHours < 2;
  }
}
