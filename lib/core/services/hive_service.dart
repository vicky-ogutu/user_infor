import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String usersBox = 'users_box';
  static const String todosBox = 'todos_box';
  static const String postsBox = 'posts_box';

  static Future<void> init() async {
    await Hive.initFlutter();

    await Hive.openBox(usersBox);
    await Hive.openBox(todosBox);
    await Hive.openBox(postsBox);
  }

  static Box getUsersBox() {
    return Hive.box(usersBox);
  }

  static Box getTodosBox() {
    return Hive.box(todosBox);
  }

  static Box getPostsBox() {
    return Hive.box(postsBox);
  }
}