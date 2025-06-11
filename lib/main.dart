import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:td_flutter_unit/pages/base/base_page.dart';
import 'package:td_flutter_unit/tds_unit.dart';
import 'package:td_flutter_unit/utils/global_timer.dart';

void main() {
  runApp(TimerWrapper(child: ProviderScope(child: TDUnit())));
}

class TimerWrapper extends StatelessWidget{
  final Widget child;


  const TimerWrapper({super.key,required this.child});

  @override
  Widget build(BuildContext context) {
    return AppTimeScope(notifier: GlobalTimer(),child: child);
  }

}