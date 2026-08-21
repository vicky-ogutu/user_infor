import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constants/app_constants.dart';
import '../../core/services/hive_service.dart';
import '../../domain/entities/posts.dart';
import '../models/posts_model.dart';



class PostRepository {
  final http.Client client;

  PostRepository({
    required this.client,
  });

  // ============================================================
  // GET POSTS
  // ============================================================

  Future<List<Post>> getPosts() async {
    try {
      final response = await client.get(
        Uri.parse(ApiConstants.posts),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data =
        jsonDecode(response.body);

        final posts = data
            .map(
              (json) => PostModel.fromJson(
            json,
          ),
        )
            .toList();

        await _cachePosts(posts);

        return posts;
      }

      return _getCachedPosts();
    } catch (e) {
      return _getCachedPosts();
    }
  }


  Future<Post?> getPostById(
      int id,
      ) async {
    try {
      final response = await client.get(
        Uri.parse(
          '${ApiConstants.posts}/$id',
        ),
      );

      if (response.statusCode == 200) {
        return PostModel.fromJson(
          jsonDecode(response.body),
        );
      }

      return _getCachedPostById(id);
    } catch (e) {
      return _getCachedPostById(id);
    }
  }

  Future<Post> addPost({
    required int userId,
    required String title,
    required String body,
  }) async {
    final newPost = PostModel(
      id: DateTime.now()
          .millisecondsSinceEpoch,
      userId: userId,
      title: title,
      body: body,
    );

    try {
      final response = await client.post(
        Uri.parse(ApiConstants.posts),
        headers: {
          'Content-Type':
          'application/json',
        },
        body: jsonEncode(
          newPost.toJson(),
        ),
      );

      if (response.statusCode == 201) {
        final createdPost =
        PostModel.fromJson(
          jsonDecode(response.body),
        );

        await _addPostToCache(
          createdPost,
        );

        return createdPost;
      }
    } catch (_) {
      // Save locally if API fails.
    }

    await _addPostToCache(
      newPost,
    );

    return newPost;
  }

  // ============================================================
  // CACHE POSTS
  // ============================================================

  Future<void> _cachePosts(
      List<PostModel> posts,
      ) async {
    final box =
    HiveService.getPostsBox();

    final postsMap = posts
        .map(
          (post) => post.toMap(),
    )
        .toList();

    await box.put(
      'posts',
      postsMap,
    );
  }

  // ============================================================
  // GET CACHED POSTS
  // ============================================================

  List<Post> _getCachedPosts() {
    final box =
    HiveService.getPostsBox();

    final cachedPosts =
    box.get('posts');

    if (cachedPosts == null) {
      return [];
    }

    return (cachedPosts as List)
        .map(
          (post) => PostModel.fromMap(
        Map<dynamic, dynamic>.from(
          post,
        ),
      ),
    )
        .toList();
  }

  // ============================================================
  // GET CACHED SINGLE POST
  // ============================================================

  Post? _getCachedPostById(
      int id,
      ) {
    final posts =
    _getCachedPosts();

    try {
      return posts.firstWhere(
            (post) => post.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  // ============================================================
  // ADD POST TO CACHE
  // ============================================================

  Future<void> _addPostToCache(
      PostModel post,
      ) async {
    final box =
    HiveService.getPostsBox();

    final cachedPosts =
    box.get('posts');

    List<Map<String, dynamic>>
    posts = [];

    if (cachedPosts != null) {
      posts = (cachedPosts as List)
          .map(
            (item) =>
        Map<String, dynamic>.from(
          item,
        ),
      )
          .toList();
    }

    posts.insert(
      0,
      post.toMap(),
    );

    await box.put(
      'posts',
      posts,
    );
  }
}