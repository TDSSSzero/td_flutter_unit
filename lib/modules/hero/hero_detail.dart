import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:td_flutter_unit/modules/base/base_page.dart';
import 'package:td_flutter_unit/modules/hero/photo_hero.dart';

class HeroDetailPage extends ConsumerWidget {
  const HeroDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BasePage(
      title: 'hero detail page',
      child: Container(
                    color: Colors.lightBlueAccent,
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.topLeft,
                    child: PhotoHero(
                      photo: 'assets/dog.png',
                      width: 100.0,
                      onTap: () {
                        // Navigator.of(context).pop();
                        context.pop();
                      },
                    ),
                  ),
    );
  }
}