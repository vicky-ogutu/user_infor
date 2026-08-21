import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/todo_providers.dart';
import 'add_todo.dart';


class TodosScreen extends ConsumerWidget {
  const TodosScreen({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final todosAsync =
    ref.watch(todosProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),

      floatingActionButton:
      FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
              const AddTodoScreen(),
            ),
          );

          ref.invalidate(
            todosProvider,
          );
        },
      ),

      body: todosAsync.when(
        loading: () =>
        const Center(
          child:
          CircularProgressIndicator(),
        ),

        error: (error, stackTrace) =>
            Center(
              child: Text(
                'Error: $error',
              ),
            ),

        data: (todos) {
          if (todos.isEmpty) {
            return const Center(
              child: Text(
                'No todos found',
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(
                todosProvider,
              );

              await ref.read(
                todosProvider.future,
              );
            },
            child: ListView.builder(
              itemCount:
              todos.length,
              itemBuilder:
                  (context, index) {
                final todo =
                todos[index];

                return Card(
                  margin:
                  const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  child: ListTile(
                    leading:
                    Checkbox(
                      value:
                      todo.completed,
                      onChanged: null,
                    ),

                    title: Text(
                      todo.title,
                      style: TextStyle(
                        decoration:
                        todo.completed
                            ? TextDecoration
                            .lineThrough
                            : null,
                      ),
                    ),

                    subtitle: Text(
                      'User ID: ${todo.userId}',
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}