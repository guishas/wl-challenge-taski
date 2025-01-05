class Task {
  int? id;
  String? title;
  String? description;
  bool? isCompleted;
  DateTime? createdAt;

  Task({
    this.id,
    required this.title,
    this.description,
    required this.isCompleted,
    required this.createdAt,
  });

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    isCompleted = json['is_completed'] == 1 ? true : false;
    createdAt = DateTime.parse(json['created_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "is_completed": isCompleted! ? 1 : 0,
      "created_at": createdAt?.toIso8601String(),
    };
  }
}
