import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/todos_model.dart';
import 'repository_providers.dart';

final todosProvider = FutureProvider<List<Todo>>(
      (ref) async {
    final repository = ref.watch(
      todoRepositoryProvider,
    );

    final List<Todo> todos =
    await repository.getTodos();

    return todos;
  },
);


final addTodoProvider =
FutureProvider.family<Todo, String>(
      (ref, title) async {
    final repository = ref.read(
      todoRepositoryProvider,
    );

    final Todo todo =
    await repository.addTodo(
      title: title,
    );

    // Refresh todos after adding
    ref.invalidate(todosProvider);

    return todo;
  },
);