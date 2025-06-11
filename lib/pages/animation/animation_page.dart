import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../navigation/router/app_route.dart';
import '../../pages/home_provider.dart';
import '../base/base_page.dart';
import '../widget/td_nav_button.dart';

class AnimationPage extends ConsumerWidget {
  const AnimationPage({super.key});


  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      body:BasePage(
          title: ref.watch(curMenuItemProvider).name,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TdNavButton(AppRoute.lottie.url,text: "lottie"),
                TdNavButton(AppRoute.heroDemo.url,text: "hero"),
              ],
            ),
          )
      ),
    );
  }
}
