import 'package:go_router/go_router.dart';
import 'package:td_flutter_unit/modules/book_anim/book_anim_page.dart';
import 'package:td_flutter_unit/modules/calendar/calendar_page.dart';
import 'package:td_flutter_unit/modules/chart/chart_page.dart';
import 'package:td_flutter_unit/modules/chart/view/chart_sales.dart';
import 'package:td_flutter_unit/modules/chart/view/chart_weather.dart';
import 'package:td_flutter_unit/modules/chart/view/chart_web_traffic.dart';
import 'package:td_flutter_unit/modules/hero/hero_demo.dart';
import 'package:td_flutter_unit/modules/hero/hero_detail.dart';
import 'package:td_flutter_unit/modules/load_more/load_more.dart';
import 'package:td_flutter_unit/modules/load_more/view/load_more_grid.dart';
import 'package:td_flutter_unit/modules/load_more/view/load_more_list.dart';
import 'package:td_flutter_unit/modules/load_more/view/load_more_sliver_grid.dart';
import 'package:td_flutter_unit/modules/load_more/view/load_more_sliver_list.dart';
import 'package:td_flutter_unit/modules/login/login_page.dart';
import 'package:td_flutter_unit/modules/lottie/lottie.dart';
import 'package:td_flutter_unit/modules/signal_demo/signal_demo.dart';
import 'package:td_flutter_unit/navigation/router/app_route.dart';


List<GoRoute> menuRoute = [
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

  GoRoute(
    path: AppRoute.loadMore.path,
    builder: (context, state) => LoadMorePage(),
    routes: [
      GoRoute(
        path: AppRoute.loadMoreList.path,
        builder: (context, state) => LoadMoreListPage(),
      ),
      GoRoute(path: AppRoute.loadMoreGrid.path,builder: (context, state) => LoadMoreGridPage(),),
      GoRoute(path: AppRoute.loadMoreSliverList.path,builder: (context, state) => LoadMoreSliverListPage()),
      GoRoute(path: AppRoute.loadMoreWaterfallFlow.path,builder: (context, state) => LoadMoreWaterfallFlowPage()),
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
    ]
  ),
  
      
];

