import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/users.dart';
import 'repository_providers.dart';

final usersProvider =
FutureProvider<List<User>>(
      (ref) async {
    final repository = ref.watch(
      userRepositoryProvider,
    );

    return repository.getUsers();
  },
);