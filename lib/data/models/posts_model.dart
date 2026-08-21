
import '../../domain/entities/posts.dart';

class PostModel extends Post {
  const PostModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.body,
  });

  factory PostModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return PostModel(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
    );
  }

  factory PostModel.fromMap(
      Map<dynamic, dynamic> map,
      ) {
    return PostModel(
      id: map['id'] ?? 0,
      userId: map['userId'] ?? 0,
      title: map['title'] ?? '',
      body: map['body'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
    };
  }


  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': title,
      'body': body,
    };
  }
}