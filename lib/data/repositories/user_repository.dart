import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constants/app_constants.dart';
import '../../core/services/hive_service.dart';
import '../../domain/entities/users.dart';
import '../models/user_model.dart';

class UserRepository {
  final http.Client client;

  UserRepository({
    required this.client,
  });

  Future<List<User>> getUsers() async {
    try {
      final response = await client.get(
        Uri.parse(ApiConstants.users),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        final users = data
            .map(
              (json) => UserModel.fromJson(json),
        )
            .toList();

        await _cacheUsers(users);

        return users;
      } else {
        return _getCachedUsers();
      }
    } catch (e) {
      return _getCachedUsers();
    }
  }

  Future<void> _cacheUsers(
      List<UserModel> users,
      ) async {
    final box = HiveService.getUsersBox();

    final usersMap = users
        .map(
          (user) => user.toMap(),
    )
        .toList();

    await box.put(
      'users',
      usersMap,
    );
  }

  List<User> _getCachedUsers() {
    final box = HiveService.getUsersBox();

    final cachedUsers =
    box.get('users');

    if (cachedUsers == null) {
      return [];
    }

    final users = (cachedUsers as List)
        .map(
          (user) => UserModel.fromMap(
        Map<dynamic, dynamic>.from(user),
      ),
    )
        .toList();

    return users;
  }
}