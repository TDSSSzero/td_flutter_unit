import 'package:flutter/material.dart';
import 'package:td_flutter_unit/pages/base/base_page.dart';

import '../../../navigation/router/app_route.dart';
import '../../widget/td_nav_button.dart';

class LearnStatePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'learn state',
      child:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TdNavButton(AppRoute.diskManager.url,text: 'diskManager',)
          ],
        ),
      ),
    );
  }
}
