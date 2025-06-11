import 'package:go_router/go_router.dart';
import 'package:td_flutter_unit/pages/animation/animation_page.dart';
import 'package:td_flutter_unit/pages/book_anim/book_anim_page.dart';
import 'package:td_flutter_unit/pages/calendar/calendar_page.dart';
import 'package:td_flutter_unit/pages/chart/chart_page.dart';
import 'package:td_flutter_unit/pages/chart/view/chart_sales.dart';
import 'package:td_flutter_unit/pages/chart/view/chart_weather.dart';
import 'package:td_flutter_unit/pages/chart/view/chart_web_traffic.dart';
import 'package:td_flutter_unit/pages/learn/learn_page.dart';
import 'package:td_flutter_unit/pages/learn/state/diskmanager/disk_manager_page.dart';
import 'package:td_flutter_unit/pages/learn/state/learn_state_page.dart';
import 'package:td_flutter_unit/pages/load_more/load_more.dart';
import 'package:td_flutter_unit/pages/load_more/view/load_more_grid.dart';
import 'package:td_flutter_unit/pages/load_more/view/load_more_list.dart';
import 'package:td_flutter_unit/pages/load_more/view/load_more_sliver_grid.dart';
import 'package:td_flutter_unit/pages/load_more/view/load_more_sliver_list.dart';
import 'package:td_flutter_unit/pages/login/login_page.dart';
import 'package:td_flutter_unit/pages/signal_demo/signal_demo.dart';
import 'package:td_flutter_unit/navigation/router/app_route.dart';

import '../../pages/animation/hero/hero_demo.dart';
import '../../pages/animation/hero/hero_detail.dart';
import '../../pages/animation/lottie/lottie.dart';

List<GoRoute> menuRoute = [
  GoRoute(path: AppRoute.animations.path,
  builder: (_,__) => AnimationPage(),
  routes: [
    GoRoute(
      path: AppRoute.lottie.path,
      builder: (context, state) => LottiePage(),
    ),

    GoRoute(
      path: AppRoute.heroDemo.path,
      builder: (context, state) => HeroDemoPage(),
    ),
    GoRoute(
      path: AppRoute.heroDetail.path,
      builder: (context, state) => HeroDetailPage(),
    ),
  ]),


  GoRoute(
    path: AppRoute.loadMore.path,
    builder: (context, state) => LoadMorePage(),
    routes: [
      GoRoute(
        path: AppRoute.loadMoreList.path,
        builder: (context, state) => LoadMoreListPage(),
      ),
      GoRoute(
        path: AppRoute.loadMoreGrid.path,
        builder: (context, state) => LoadMoreGridPage(),
      ),
      GoRoute(
        path: AppRoute.loadMoreSliverList.path,
        builder: (context, state) => LoadMoreSliverListPage(),
      ),
      GoRoute(
        path: AppRoute.loadMoreWaterfallFlow.path,
        builder: (context, state) => LoadMoreWaterfallFlowPage(),
      ),
    ],
  ),

  GoRoute(
    path: AppRoute.loginPage.path,
    builder: (context, state) => LoginPage(),
  ),

  GoRoute(
    path: AppRoute.book.path,
    builder: (context, state) => BookAnimPage(),
  ),

  GoRoute(
    path: AppRoute.calendar.path,
    builder: (context, state) => CalendarPage(),
  ),

  GoRoute(
    path: AppRoute.signalDemo.path,
    builder: (context, state) => SignalDemoPage(),
  ),

  GoRoute(
    path: AppRoute.chart.path,
    builder: (context, state) => ChartPage(),
    routes: [
      GoRoute(
        path: AppRoute.chartOfSales.path,
        builder: (context, state) => ChartOfSalesPage(),
      ),
      GoRoute(
        path: AppRoute.chartOfWebTraffic.path,
        builder: (context, state) => ChartOfWebTrafficPage(),
      ),
      GoRoute(
        path: AppRoute.chartOfWeather.path,
        builder: (context, state) => ChartOfWeatherPage(),
      ),
    ],
  ),

  GoRoute(
    path: AppRoute.learn.path,
    builder: (context, state) => LearnPage(),
    routes: [
      GoRoute(
        path: AppRoute.learnState.path,
        builder: (context, state) => LearnStatePage(),
        routes: [
          GoRoute(
            path: AppRoute.diskManager.path,
            builder: (context, state) => DiskManagerPage(),
          ),
        ],
      ),
    ],
  ),
];
