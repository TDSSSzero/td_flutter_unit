
import 'package:flutter/material.dart';
import 'package:td_flutter_unit/modules/base/base_page.dart';

class Error404Page extends StatelessWidget {
  const Error404Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(title: '404',child: Text('404 page not found'));
  }
}