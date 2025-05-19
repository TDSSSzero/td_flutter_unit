import 'package:flutter/material.dart';

class TdButtonList extends StatelessWidget {

  const TdButtonList({super.key,required this.itemCount,required this.itemBuilder});

  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (c,__) => 
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          itemBuilder(c,__),
        ],
      ),
       separatorBuilder: _buildSeparator,
        itemCount: itemCount,
        );
  }

  Widget _buildSeparator(BuildContext context, int index) {
    return const SizedBox(height: 10);
  }

}