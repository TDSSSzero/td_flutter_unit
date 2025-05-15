import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:td_flutter_unit/modules/base/base_page.dart';
import 'package:td_flutter_unit/theme/theme_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BasePage(
      title: '设置',
      child: ListView(
        children: [
          ListTile(
            title: const Text('深色模式'),
            trailing: Switch(
              value: ref.watch(themeProvider) == ThemeMode.dark,
              onChanged: (bool value) {
                ref.read(themeProvider.notifier).setThemeMode(
                  value ? ThemeMode.dark : ThemeMode.light
                );
              },
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}