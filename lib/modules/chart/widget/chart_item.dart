import 'package:flutter/material.dart';
import 'package:td_flutter_unit/utils/ui_util.dart';

class ChartItem extends StatelessWidget {
  const ChartItem({super.key,required this.chartItem});

  final Widget chartItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            width: context.screenWidth,
            height: context.screenHeight * 0.7,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: chartItem,
            ),
          );
  }
}