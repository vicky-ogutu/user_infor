import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constants/app_constants.dart';
import '../../core/services/hive_service.dart';
import '../models/todos_model.dart';



class TodoRepository {
  final http.Client client;

  TodoRepository({
    required this.client,
  });

  Future<List<Todo>> getTodos() async {
    try {
      final response = await client.get(
        Uri.parse(ApiConstants.todos),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data =
        jsonDecode(response.body);

        final List<TodoModel> todos = data
            .map<TodoModel>(
              (json) => TodoModel.fromJson(
            json as Map<String, dynamic>,
          ),
        )
            .toList();

        await _cacheTodos(todos);

        return todos;
      }

      return _getCachedTodos();
    } catch (e) {
      return _getCachedTodos();
    }
  }
  Future<TodoModel> addTodo({
    required String title,
  }) async {
    final todo = TodoModel(
      id: DateTime.now().millisecondsSinceEpoch,
      userId: 1,
      title: title,
      completed: false,
    );

    try {
      final response = await client.post(
        Uri.parse(ApiConstants.todos),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          todo.toJson(),
        ),
      );

      if (response.statusCode == 201) {
        final createdTodo = TodoModel.fromJson(
          jsonDecode(response.body),
        );

        await _addTodoToCache(createdTodo);

        return createdTodo;
      }
    } catch (_) {
      // Continue and save locally.
    }

    await _addTodoToCache(todo);

    return todo;
  }

  Future<void> _cacheTodos(
      List<TodoModel> todos,
      ) async {
    final box = HiveService.getTodosBox();

    final todoMaps = todos
        .map(
          (todo) => todo.toMap(),
    )
        .toList();

    await box.put(
      'todos',
      todoMaps,
    );
  }

  List<Todo> _getCachedTodos() {
    final box = HiveService.getTodosBox();

    final cachedTodos = box.get('todos');

    if (cachedTodos == null) {
      return <Todo>[];
    }

    return (cachedTodos as List)
        .map<Todo>(
          (todo) => TodoModel.fromMap(
        Map<dynamic, dynamic>.from(todo),
      ),
    )
        .toList();
  }

  Future<void> _addTodoToCache(
      TodoModel todo,
      ) async {
    final box = HiveService.getTodosBox();

    final cachedTodos =
    box.get('todos');

    List<Map<String, dynamic>> todos = [];

    if (cachedTodos != null) {
      todos = (cachedTodos as List)
          .map(
            (item) => Map<String, dynamic>.from(item),
      )
          .toList();
    }

    todos.insert(
      0,
      todo.toMap(),
    );

    await box.put(
      'todos',
      todos,
    );
  }
}