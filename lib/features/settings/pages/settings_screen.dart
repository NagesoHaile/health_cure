import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_cure/config/route/route_name.dart';
import 'package:health_cure/core/common/theme_bloc/theme_bloc.dart';
import 'package:health_cure/core/database/local_storage.dart';
import 'package:health_cure/features/authentication/services/authentication_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    title: const Text('Logout'),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            await LocalStorage.instance.setBool('user_logged_in', false);
                            await AuthenticationService().signOut();
                            context.goNamed(RouteName.login);
                          },
                          child: const Text('Yes')),
                      ElevatedButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: const Text('No'))
                    ],
                  ),
                );
              }, icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSection(
              context,
              title: 'Profile',
              children: [
                ListTile(
                  title: const Text('Profile'),
                  subtitle: Text('Your profile settings',style:Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),),
                  trailing: const Icon(Icons.person),
                  onTap: () async {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Coming soong.')),
                    );
                  },
                ),
              ],
            ),

            SizedBox(height: 16),
            _buildSection(
              context,
              title: 'Appearance',
              children: [
                SwitchListTile(
                  title: const Text('Dark Mode'),
                  subtitle:  Text('Enable dark theme',style:Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),),
                  value: Theme.of(context).brightness == Brightness.dark,
                  onChanged: (value) {
                    context.read<ThemeBloc>().add(ThemeEvent());
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: 'Others',
              children: [
                ListTile(
                  title: const Text('Feedback'),
                  subtitle: Text(
                    'Share your feedback with us',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  leading: const Icon(Icons.feedback),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // TODO: Implement privacy policy
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Feedback coming soon...')),
                    );
                  },
                ),
                Divider(color: Colors.grey.shade300),
                ListTile(
                  title: const Text('Share App'),
                  subtitle: Text(
                    'Share the app with your friends',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  leading: const Icon(Icons.share),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // TODO: Implement privacy policy
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Share app coming soon...')),
                    );
                  },
                ),
                Divider(color: Colors.grey.shade300),
                ListTile(
                  title: const Text('Rate App'),
                  subtitle: Text(
                    'Rate the app',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  leading: const Icon(Icons.star),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // TODO: Implement terms of service
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Rate app coming soon...')),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: 'About',
              children: [
                ListTile(
                  title: const Text('Version'),
                  subtitle: Text(
                    '1.0.0',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                Divider(color: Colors.grey.shade300),
                ListTile(
                  title: const Text('Privacy Policy'),
                  subtitle: Text(
                    'Read the privacy policy',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  leading: const Icon(Icons.privacy_tip),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // TODO: Implement privacy policy
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Privacy policy coming soon...'),
                      ),
                    );
                  },
                ),
                Divider(color: Colors.grey.shade300),
                ListTile(
                  title: const Text('Terms of Service'),
                  subtitle: Text(
                    'Read the terms of service',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  leading: const Icon(Icons.file_present),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // TODO: Implement terms of service
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Terms of service coming soon...'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withAlpha(10),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(5),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: children),
        ),
      ],
    );
  }
}
