import 'package:flutter/material.dart';

import '../../domain/entities/users.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(
      BuildContext context,
      ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Details',
        ),
      ),
      body: Padding(
        padding:
        const EdgeInsets.all(20),
        child: Card(
          child: Padding(
            padding:
            const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 45,
                    child: Text(
                      user.name
                          .substring(0, 1)
                          .toUpperCase(),
                      style:
                      const TextStyle(
                        fontSize: 32,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                _DetailRow(
                  icon: Icons.person,
                  title: 'Name',
                  value: user.name,
                ),

                _DetailRow(
                  icon: Icons.alternate_email,
                  title: 'Username',
                  value: user.username,
                ),

                _DetailRow(
                  icon: Icons.email,
                  title: 'Email',
                  value: user.email,
                ),

                _DetailRow(
                  icon: Icons.phone,
                  title: 'Phone',
                  value: user.phone,
                ),

                _DetailRow(
                  icon: Icons.language,
                  title: 'Website',
                  value: user.website,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(
      BuildContext context,
      ) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(
        vertical: 12,
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Icon(icon),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(value),
              ],
            ),
          ),
        ],
      ),
    );
  }
}