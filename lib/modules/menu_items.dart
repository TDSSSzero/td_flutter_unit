
import 'package:flutter/material.dart';
import 'package:td_flutter_unit/navigation/router/app_route.dart';

final List<MenuItem> menuItems = [
  MenuItem(
    route: AppRoute.lottie,
    name: "lottie动画",
    description: "Lottie动画示例",
    icon: Icons.animation
  ),
  MenuItem(
    route: AppRoute.heroDemo,
    name: "hero动画",
    description: "hero动画",
    icon: Icons.waves
  ),
  MenuItem(
    route: AppRoute.loadMore,
    name: "加载更多",
    description: "加载更多示例",
    icon: Icons.refresh
  ),
  MenuItem(
    route: AppRoute.loginPage,
    name: "登录页面",
    description: "登录页面",
    icon: Icons.login
  ),
  MenuItem(
    route: AppRoute.book,
    name: "书籍翻页",
    description: "书籍翻页",
    icon: Icons.menu_book
  ),
  MenuItem(
    route: AppRoute.calendar,
    name: "日历组件",
    description: "日历组件",
    icon: Icons.menu_book
  ),
  
  MenuItem(
    route: AppRoute.chart,
    name: "图表",
    description: "图表组件",
    icon: Icons.bar_chart
  ),

  MenuItem(
    route: AppRoute.signalDemo,
    name: "信号状态管理",
    description: "信号状态管理",
    icon: Icons.lightbulb
  ),
];

class MenuItem {
  final AppRoute route;
  final String name;
  final String? description;
  final IconData? icon;

  const MenuItem({
    required this.route,
    required this.name,
    this.description,
    this.icon,
  });
}
