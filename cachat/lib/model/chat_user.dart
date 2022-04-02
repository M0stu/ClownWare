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
    var now = DateTime.now();
    var timeCounter = now.minute - lastSeen.minute;

    if (timeCounter < 60) {
      var timeCounter = now.minute - lastSeen.minute;
      return "Last Seen $timeCounter min";
    } else {
      var timeCounter = now.hour - lastSeen.hour;
      return "Last Seen $timeCounter hours";
    }
  }

  bool wasActive() {
    return DateTime.now().difference(lastSeen).inHours < 2;
  }
}
