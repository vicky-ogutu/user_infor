// ----- Base Todo class -----
class Todo {
  final int id;
  final int userId;
  final String title;
  final bool completed;

  const Todo({
    required this.id,
    required this.userId,
    required this.title,
    required this.completed,
  });
}

// ----- Your existing TodoModel (now extends Todo) -----
class TodoModel extends Todo {
  const TodoModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.completed,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      title: json['title'] ?? '',
      completed: json['completed'] ?? false,
    );
  }

  factory TodoModel.fromMap(Map<dynamic, dynamic> map) {
    return TodoModel(
      id: map['id'] ?? 0,
      userId: map['userId'] ?? 0,
      title: map['title'] ?? '',
      completed: map['completed'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'completed': completed,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': title,
      'completed': completed,
    };
  }
}