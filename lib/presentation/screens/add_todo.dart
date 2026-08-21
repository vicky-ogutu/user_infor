import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/repository_providers.dart';
import '../providers/todo_providers.dart';


class AddTodoScreen extends ConsumerStatefulWidget {
  const AddTodoScreen({
    super.key,
  });

  @override
  ConsumerState<AddTodoScreen>
  createState() =>
      _AddTodoScreenState();
}

class _AddTodoScreenState
    extends ConsumerState<AddTodoScreen> {
  final _formKey =
  GlobalKey<FormState>();

  final _titleController =
  TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();

    super.dispose();
  }

  Future<void> _addTodo() async {
    if (!_formKey.currentState!
        .validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final repository = ref.read(
        todoRepositoryProvider,
      );

      await repository.addTodo(
        title:
        _titleController.text.trim(),
      );

      ref.invalidate(
        todosProvider,
      );

      if (!mounted) return;

      Navigator.pop(
        context,
        true,
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            'Failed to add todo: $e',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(
      BuildContext context,
      ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Todo',
        ),
      ),
      body: Padding(
        padding:
        const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller:
                _titleController,

                decoration:
                const InputDecoration(
                  labelText:
                  'Todo Title',

                  border:
                  OutlineInputBorder(),

                  prefixIcon: Icon(
                    Icons.task,
                  ),
                ),

                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Please enter a todo';
                  }

                  return null;
                },
              ),

              const SizedBox(
                height: 20,
              ),

              SizedBox(
                width:
                double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : _addTodo,

                  child: _isLoading
                      ? const SizedBox(
                    width: 25,
                    height: 25,
                    child:
                    CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                      : const Text(
                    'Add Todo',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}