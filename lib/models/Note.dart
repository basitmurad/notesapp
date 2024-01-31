class Note {
  static int _latestId = 0;

  int id;
  String title;
  String description;

  Note({
    int? id,
    required this.title,
    required this.description,
  }) : id = id ?? ++_latestId;

  factory Note.fromJson(Map<String, dynamic> json) => Note(
    id: json['id'],
    title: json['title'],
    description: json['description'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
  };
}
