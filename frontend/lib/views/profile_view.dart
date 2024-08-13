import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';

import '../providers/user_provider.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(userProvider).currentUser;

    return Padding(
      padding: const EdgeInsets.all(Insets.l * 2),
      child: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: Insets.xxl),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.onPrimary,
                size: 70,
              ),
            ),
            if (currentUser != null)
              Text(
                currentUser.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            currentUser != null
                ? Column(
                    children: [
                      const SizedBox(
                        height: Insets.l * 3,
                      ),
                      buildInfoTile(
                          context, currentUser.email, FontAwesome.envelope),
                      if (currentUser.phone.isNotBlank)
                        buildInfoTile(context, currentUser.phone!, Icons.phone),
                      buildInfoTile(
                        context,
                        currentUser.adress.street,
                        FontAwesome.location_dot_solid,
                      ),
                    ],
                  )
                : Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Text(
                          'Quando você se cadastrar seus dados aparecerão aqui.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/register-user',
                            arguments: true,
                          );
                        },
                        child: const Text('Me cadastrar agora'),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

Widget buildInfoTile(BuildContext context, String text, IconData icon) {
  return ListTile(
    dense: true,
    visualDensity: const VisualDensity(vertical: -4),
    contentPadding: EdgeInsets.zero,
    titleTextStyle: Theme.of(context).textTheme.bodySmall,
    leading: Icon(
      icon,
      color: Theme.of(context).colorScheme.secondary,
      size: 18,
    ),
    title: Text(text),
  );
}
