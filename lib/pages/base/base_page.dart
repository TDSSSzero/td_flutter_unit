import 'package:flutter/material.dart';
import 'package:td_flutter_unit/modules/user_info/user_info_manager.dart';
import 'package:td_flutter_unit/utils/global_timer.dart';

class BasePage extends StatelessWidget {
  final Widget child;
  final String? title;
  final Color? backgroundColor;

  const BasePage({
    super.key,
    required this.child,
    this.title,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withOpacity(0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        automaticallyImplyLeading: true,
        title: title == null ? null : Text(title!),
        actions: [
          AppRouteCounter()
        ],
      ),
      body: child,
    );
  }
}

class AppTimeScope extends InheritedNotifier<GlobalTimer>{
  const AppTimeScope({super.key,super.notifier, required super.child});

  static GlobalTimer of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppTimeScope>()!.notifier!;
  }

  static GlobalTimer read(BuildContext context) {
    return context.getInheritedWidgetOfExactType<AppTimeScope>()!.notifier!;
  }
}

class AppRouteCounter extends StatefulWidget {
  const AppRouteCounter({
    super.key,
  });

  @override
  State<AppRouteCounter> createState() => _AppRouteCounterState();
}

class _AppRouteCounterState extends State<AppRouteCounter> {

  @override
  void initState() {
    UserInfoManager().addListener(_onCountChanged);
    super.initState();
  }

  @override
  void dispose() {
    UserInfoManager().removeListener(_onCountChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text('count: ${UserInfoManager().routeCount}');
  }

  _onCountChanged(){
    setState(() {

    });
  }
}
