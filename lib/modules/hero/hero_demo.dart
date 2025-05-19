import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:td_flutter_unit/modules/base/base_page.dart';
import 'package:td_flutter_unit/modules/hero/photo_hero.dart';
import 'package:td_flutter_unit/navigation/router/app_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:td_flutter_unit/pages/home_provider.dart';

class HeroDemoPage extends ConsumerWidget {
  const HeroDemoPage({super.key});
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final tag = "assets/dog.png";
    return BasePage(
      title: ref.watch(curMenuItemProvider).name,
      child: Center(
        child: PhotoHero(
          photo: tag,
           width: 50,
           onTap: (){
            context.push(AppRoute.heroDetail.url);
           },
           ),
      )
    );
  }
}
