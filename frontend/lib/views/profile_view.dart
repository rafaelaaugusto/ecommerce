import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/theme/colors_theme.dart';
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
    final user = ref.watch(userProvider).currentUser;

    return Padding(
      padding: const EdgeInsets.all(Insets.l * 2),
      child: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: Insets.xxl),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: primary,
              ),
              child: const Icon(
                Icons.person,
                color: onPrimary,
                size: 70,
              ),
            ),
            if (user != null)
              Text(
                user.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            user != null
                ? Column(
                    children: [
                      const SizedBox(
                        height: Insets.l * 3,
                      ),
                      buildInfoTile(context, user.email, FontAwesome.envelope),
                      if (user.phone.isNotBlank)
                        buildInfoTile(context, user.phone!, Icons.phone),
                      buildInfoTile(
                        context,
                        user.adress.street,
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
                          Navigator.popAndPushNamed(
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
      color: secondary,
      size: 18,
    ),
    title: Text(text),
  );
}
