import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/posts.dart';
import 'repository_providers.dart';

final postsProvider =
FutureProvider<List<Post>>(
      (ref) async {
    final repository = ref.watch(
      postRepositoryProvider,
    );

    return repository.getPosts();
  },
);


final postByIdProvider =
FutureProvider.family<Post?, int>(
      (ref, id) async {
    final repository = ref.watch(
      postRepositoryProvider,
    );

    return repository.getPostById(
      id,
    );
  },
);

final addPostProvider =
FutureProvider.family<
    Post,
    AddPostParams>(
      (ref, params) async {
    final repository = ref.read(
      postRepositoryProvider,
    );

    final post =
    await repository.addPost(
      userId: params.userId,
      title: params.title,
      body: params.body,
    );

    ref.invalidate(
      postsProvider,
    );

    return post;
  },
);

class AddPostParams {
  final int userId;
  final String title;
  final String body;

  const AddPostParams({
    required this.userId,
    required this.title,
    required this.body,
  });
}