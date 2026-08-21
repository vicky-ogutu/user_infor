import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../data/repositories/posts_repository.dart';
import '../../data/repositories/todos_repository.dart';
import '../../data/repositories/user_repository.dart';

final httpClientProvider = Provider<http.Client>(
      (ref) {
    final client = http.Client();

    ref.onDispose(
      client.close,
    );

    return client;
  },
);


final userRepositoryProvider = Provider<UserRepository>(
      (ref) {
    return UserRepository(
      client: ref.watch(httpClientProvider),
    );
  },
);
final todoRepositoryProvider = Provider<TodoRepository>(
      (ref) {
    return TodoRepository(
      client: ref.watch(httpClientProvider),
    );
  },
);

final postRepositoryProvider = Provider<PostRepository>(
      (ref) {
    return PostRepository(
      client: ref.watch(httpClientProvider),
    );
  },
);