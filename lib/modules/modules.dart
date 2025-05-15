import 'package:flutter/material.dart';
import 'package:td_flutter_unit/navigation/router/app_route.dart';

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

final List<MenuItem> menuItems = [
  MenuItem(
    route: AppRoute.lottie,
    name: "lottie动画",
    description: "Lottie动画示例",
    icon: Icons.animation
  ),
  MenuItem(
    route: AppRoute.loadMore,
    name: "加载更多",
    description: "加载更多示例",
    icon: Icons.refresh
  ),
];