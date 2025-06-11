import 'package:flutter/material.dart';
import 'package:td_flutter_unit/pages/base/base_page.dart';
import 'package:td_flutter_unit/pages/widget/td_nav_button.dart';
import 'package:td_flutter_unit/navigation/router/app_route.dart';
import 'package:td_flutter_unit/navigation/router/app_router.dart';

class LearnPage extends StatelessWidget {
  const LearnPage({super.key});


  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'learn',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TdNavButton(AppRoute.learnState.url,text: '状态',)
          ],
        ),
      ),
    );
  }

}
