import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_infor/presentation/screens/user_details.dart';

import '../providers/user_providers.dart';



class UsersScreen extends ConsumerWidget {
  const UsersScreen({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final usersAsync =
    ref.watch(usersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: usersAsync.when(
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

        data: (users) {
          if (users.isEmpty) {
            return const Center(
              child: Text(
                'No users found',
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(
                usersProvider,
              );

              await ref.read(
                usersProvider.future,
              );
            },
            child: ListView.builder(
              itemCount:
              users.length,
              itemBuilder:
                  (context, index) {
                final user =
                users[index];

                return Card(
                  margin:
                  const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading:
                    CircleAvatar(
                      child: Text(
                        user.id.toString(),
                      ),
                    ),

                    title: Text(
                      user.name,
                    ),

                    subtitle: Text(
                      user.email,
                    ),

                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                    ),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              UserDetailScreen(
                                user: user,
                              ),
                        ),
                      );
                    },
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