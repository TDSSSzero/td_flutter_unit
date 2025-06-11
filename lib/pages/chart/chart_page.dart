import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:td_flutter_unit/pages/base/base_page.dart';
import 'package:td_flutter_unit/pages/widget/td_nav_button.dart';
import 'package:td_flutter_unit/navigation/router/app_route.dart';
import 'package:td_flutter_unit/pages/home_provider.dart';


class ChartPage extends ConsumerStatefulWidget {
  const ChartPage({super.key});

  
@override
  ConsumerState<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends ConsumerState<ChartPage> {

@override
  Widget build(BuildContext context) {
    return BasePage(
      title: ref.watch(curMenuItemProvider).name,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TdNavButton(AppRoute.chartOfSales.url,text: "销售统计",),
            // TdNavButton(AppRoute.chartOfWebTraffic.url,text: "网站流量统计",),
            // TdNavButton(AppRoute.chartOfWeather.url,text: "天气统计",),
          ],
        ),
      )
      );
  }
}
