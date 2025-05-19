import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TdNavButton extends StatelessWidget {

  const TdNavButton(this.url,{this.child,this.text,super.key});

  final String url;
  final Widget? child;
  final String? text;

  @override
  Widget build(BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: ElevatedButton(onPressed: () => context.push(url), child: text == null ? child : Text(text!)),);
  }
}
