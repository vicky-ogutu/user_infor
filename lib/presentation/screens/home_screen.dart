import 'package:flutter/material.dart';
import 'package:user_infor/presentation/screens/post_screen.dart';
import 'package:user_infor/presentation/screens/todos_screen.dart';
import 'package:user_infor/presentation/screens/users_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'JSONPlaceholder App',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _HomeCard(
              title: 'Users',
              subtitle:
              'View users and their details',
              icon: Icons.people,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                    const UsersScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            _HomeCard(
              title: 'Todos',
              subtitle:
              'View and add todos',
              icon: Icons.check_circle,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                    const TodosScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            _HomeCard(
              title: 'Posts',
              subtitle:
              'View Posts',
              icon: Icons.check_circle,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                    const PostScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _HomeCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        borderRadius:
        BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding:
          const EdgeInsets.all(24),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                child: Icon(
                  icon,
                  size: 30,
                ),
              ),

              const SizedBox(width: 20),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge,
                    ),

                    const SizedBox(height: 6),

                    Text(
                      subtitle,
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.arrow_forward_ios,
              ),
            ],
          ),
        ),
      ),
    );
  }
}